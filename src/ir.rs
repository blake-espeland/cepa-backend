/*
    Container for internal representations (IRs) of all common objects.

    All objects intended to be transmitted using GraphQL must derive the
    GraphQLObject trait.


    TODO: Add lisense
*/

use juniper::{GraphQLObject, ID};

const PRODUCT_PREFIX: &str = "PROD_";

/*********************************************/
/* Public fn's*/
/*********************************************/

/*********************************************/
/* Public ENUMS */
/*********************************************/

/*********************************************/
/* Public STRUCTS */
/*********************************************/

#[derive(GraphQLObject, Debug)]
// Object describing a person within society. The root human object.
pub struct Person {
    pub id: ID,
    // Number of owned tokens.
    owned_tokens: Vec<ID>,

    // Is the person alive?
    alive: bool,
    // Is the person retired?
    retired: bool,
    // Is ther person married?
    married: bool,
}

#[derive(GraphQLObject, Debug)]
pub struct Product {
    pub id: ID,
    name: String,

    // Market clearing rate (not necessary for non-consumer goods)
    market_clearing_rate: Option<f64>,

    direct_labor: f64,
    input_labor: f64,

    pub net_output: f64,
    pub target_output: f64,
}

#[derive(GraphQLObject, Debug)]
pub struct Producer {
    pub id: ID,

    // can be retrieved by their i32 from db hash
    workers: Vec<ID>,
    // can be retrieved by their i32 from db hash
    products: Vec<ID>,
}

#[derive(GraphQLObject, Debug)]
pub struct Worker {
    // Association to producer
    producer_id: ID,
    // Associated personal information
    persona: Person,
}

#[derive(GraphQLObject, Debug)]
pub struct LaborToken {
    pub id: ID,
    // Person i32 of owner. Database is queried in order to retrieve the
    // object that owns this token.
    pub owned_by: ID,
    // how long does the token have to live?
    pub ttl: i32,

    // has the token been spent?
    valid: bool,
    // is this token being saved?
    saved: bool,
    // has this toke been credited?
    credited: bool,
}

/*********************************************/
/* Public TRAITS */
/*********************************************/

/*********************************************/
/* Public IMPL */
/*********************************************/

impl Product {
    pub fn new(id_: ID) -> Self {
        Product {
            id: id_.clone(),
            name: format!("{}{}", PRODUCT_PREFIX, id_.clone()),
            market_clearing_rate: None,
            direct_labor: 0.0,
            input_labor: 0.0,
            net_output: 0.0,
            target_output: 0.0,
        }
    }

    pub fn give_name(&mut self, name: String) {
        self.name = name;
    }
}

impl Producer {
    pub fn new(id: ID) -> Self {
        Producer {
            id: id,
            workers: Vec::new(),
            products: Vec::new(),
        }
    }

    pub fn assign_product(&mut self, product: ID) -> () {
        self.products.push(product);
    }
}
