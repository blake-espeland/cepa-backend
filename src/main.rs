mod controller;
// mod data_broker;
mod db;
mod ir;
// mod net_broker;
mod simulation;

use simulation::simulate;
use clap::Parser;

/// Simple program to greet a person
#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Name of the person to greet
    #[arg(short, long, default_value_t = true)]
    simulate: bool,
}

fn main() {
    let args = Args::parse();

    if args.simulate {
        simulate(String::from("C:/Users/blake/OneDrive/Desktop/Coding projects/Cybernetics/cepa_backend/sim_cfg.json"));
    }
}
