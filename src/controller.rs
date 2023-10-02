use crate::ir::Product;

/*********************************************/
/* Const def */
/*********************************************/

const E: f64 = 2.71828182;
// Arbitrary step value for computing dH
const DELTA: f64 = 1e-5;


/*********************************************/
/* Private utilities */
/*********************************************/

/*
    Private harmony calcualtion. No other component needs exposure to this calculation.
    The Harmonious trait is what allows components to get the harmony value.
*/
fn harmony(net_output: f64, target_output: f64) -> f64 {
    let delta = (net_output - target_output) / target_output;
    let neg = delta < 0.0;

    if neg {
        delta - (delta * delta) * 0.5
    }
    else {
        (delta + 1.0).log(E)
    }
}

/*********************************************/
/* Public trait def */
/*********************************************/

pub trait Harmonious {
    fn h(&self) -> f64;
    fn dh(&self) -> f64;
}


/*********************************************/
/* Implementations */
/*********************************************/ 

/* See Harmonious trait */
impl Harmonious for Product {
    fn h(&self) -> f64 {
        harmony(self.net_output, self.target_output)
    }

    fn dh(&self) -> f64 {
        let start = harmony(self.target_output, self.net_output);
        let step = harmony(self.target_output, self.net_output + DELTA);
    
        (step - start) / DELTA
    }
}
