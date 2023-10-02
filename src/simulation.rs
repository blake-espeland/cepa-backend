/*
    TODO - Goals for this file:
        1. Create json hyperparameter schema
        2. Read and write results from/to sim database
        3. 
*/

use crate::ir::{Product, Producer};
use crate::db::CepaID;

use std::fs;
use serde_json as sj;
use serde;
use juniper::ID;

const N_PRODUCTS: usize = 20;
const N_PRODUCERS: usize = 5;

#[derive(serde::Serialize, serde::Deserialize)]
struct SimCfg {
    nyears: usize,
}

fn parse_cfg(cfg_path: String) -> SimCfg {
    println!("Parsing {}...", cfg_path);
    // If there is an fs error, then we should just panic
    let res = fs::read(cfg_path).unwrap();
    let res_str = String::from_utf8(res).unwrap();

    let ret: SimCfg = sj::de::from_str(&res_str).unwrap();
    return ret
}

pub fn simulate(cfg_path: String) -> () {
    println!("CEPA Simulation initializing");
    let _cfg = parse_cfg(cfg_path);

    let mut id: usize = 0;
    
    let mut products: Vec<Product> = Vec::new();
    let mut producers: Vec<Producer> = Vec::new();

    for _ in 0..N_PRODUCTS {
        products.push(Product::new(ID::from_usize(id)));
        id += 1;
    }

    for _ in 0..N_PRODUCERS {
        producers.push(Producer::new(ID::from_usize(id)));
        id += 1;
    }

    for i in 0..N_PRODUCTS {
        let producer = i % N_PRODUCERS;
        let pref = &mut producers[producer];

        pref.assign_product(products[i].id.clone());
    }

    println!("Simulation complete.");
}