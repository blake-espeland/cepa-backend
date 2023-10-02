/*
    Defining the database object. For now, the database will store items on
    memory. This will eventually have to be handled differently, i.e.
    persistent storage and batching/pipelining.


    NOTICE: Work has paused on database and network-related functionality
    in order to focus on the core functionality of this library.


    TODO: Add license
*/

use crate::ir::{LaborToken, Person, Producer, Product, Worker};

use juniper::{graphql_object, FieldResult, GraphQLError, RootNode, ID};
use mysql;
use std::collections::HashMap;
use std::sync::atomic;

const ID_PREFIX: &str = "CEPA_ID_";

enum ConnectionStatus {
    Connected,
    Connecting,
    ConnectionFailed,
    Offline,
    Idle
}

struct Query;
struct Mutation;
struct Subscription;
struct Connection {
    my_ip: String,
    db_ip: String,
    status: ConnectionStatus
}
struct DBPool {
    cur_id: atomic::AtomicI32,
    connection: Connection,
    // people: HashMap<ID, Person>,
    // producers: HashMap<ID, Producer>,
    // workers: HashMap<ID, Worker>,
    //
    // tokens: HashMap<ID, LaborToken>,
    // products: HashMap<ID, Product>,
}

pub struct Context {
    pool: DBPool,
}

impl juniper::Context for Context {}

impl Connection{
    pub fn insert_product(&mut self, p: Product) -> () {
        println!("Inserting Product {}", p.id.clone());
        // todo!()
    }
    pub fn insert_producer(&mut self, p: Producer) -> () {
        println!("Inserting Producer {}", p.id.clone());
        // todo!()
    }

    pub fn find_product(&self, id: &ID) -> Product {
        println!("Finding Product {}", id.clone());
        Product::new(id.clone())
        // todo!()
    }
    pub fn find_producer(&self, id: &ID) -> Producer {
        println!("Finding Producer {}", id.clone());
        Producer::new(id.clone())
        // todo!()
    }
}

impl DBPool {
    pub fn get_connection(&self) -> Option<&Connection> {
        match self.connection.status {
            ConnectionStatus::Connected => {
                Some(&self.connection)
            }
            _ => {
                // perhaps retry connection?
                None
            }
        }
    }
}


graphql_object!(Mutation: Context |&self|{
    field createProduct(&executor, new_product: Product) -> FieldResult<Product> {
        let db = executor.context().pool.get_connection()?;
        let product: Product = db.insert_product(&new_product)?;
        Ok(product)
    }

    field createProducer(&executor, new_producer: Producer) -> FieldResult<Producer> {
        let db = executor.context().pool.get_connection()?;
        let producer: Producer = db.insert_producer(&new_producer)?;
        Ok(producer)
    }
});

graphql_object!(Query: Context |&self|{
    field getProduct(&executor, id: ID) -> FieldResult<Product> {
        // Get the context from the executor.
        let context = executor.context();
        // Get a db connection.
        let connection = context.pool.get_connection()?;
        // Execute a db query.
        // Note the use of `?` to propagate errors.
        let product = connection.find_product(&id)?;
        // Return the result.
        Ok(product)
    }

    field getProducer(&executor, id: ID) -> FieldResult<Producer> {
        // Get the context from the executor.
        let context = executor.context();
        // Get a db connection.
        let connection = context.pool.get_connection()?;
        // Execute a db query.
        // Note the use of `?` to propagate errors.
        let producer = connection.find_producer(&id)?;
        // Return the result.
        // Return the result.
        Ok(producer)
    }
});

pub trait CepaID {
    fn from_usize(int: usize) -> Self;
    fn from_i32(int: i32) -> Self;
    fn from_u32(int: u32) -> Self;
}

impl CepaID for ID {
    fn from_usize(int: usize) -> Self {
        let s = String::from(format!("{}{}", ID_PREFIX, int));
        Self::new(s)
    }
    fn from_u32(int: u32) -> Self {
        Self::from_usize(int as usize)
    }
    fn from_i32(int: i32) -> Self {
        Self::from_usize(int as usize)
    }
}

type Schema = RootNode<'static, Query, Mutation, Subscription>;

pub fn mutate_db(mutation: String) {
    todo!()
}

pub fn query_db(query: String) {
    todo!()
}
