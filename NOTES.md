Notes on "Socialist Economic Planning and Algorithms

I/O Table
 - Populate industry-industry relation data
 - Use natural units (kg, tons, bushells, etc.)
 - Thus, we can calculate the direct and indirect labor content for each industry (by using hours/unit product).
 - ~10e7 different goods in an economy. This means 10^14 entries in the table.
 - labor values = tech matrix * labor values + input vector
 - Gaussian solution is impossible due to computational intractibility.
 - However, the I/O table is HIGHLY sparse...
 - Use linked list data structure instead. 
 - An estimate is that # inputs is proportional to the logarithm of the number of products (so ~ 7 for a given product).
 - Solve iteratively instead (Jacobian mtd) nlog(n)
 - Each prod. process is a list of pairs {input code, qualtity}
 - Don't need exact solution (~3 sig figs)


Market-clearing prices are calculated for the consumer goods industries.

Harmony planning -> derivative of harmony function determines the step in production



*Harmony function is as follows:*  
H(t, n) 
    scale(t, n) -> (n - t)/t
    if s < 0:  
        H -> scale - (0.5 * scale^2)
    else:  
        H -> log(scale + 1)  

where:  
t is the target value
n is net output

*Thus dH is as follows:*
dH(t, n)
    step -> small step for derivative
    base -> H(t, n)
    basePlusStep -> H(t, n + e)
    -> (basePlusStep - base)/step

He uses harmony gain rate as an analog for profit, shift resources to areas of high gain. Harmony is a "shadow price", in effect solving the problem of pricing.

LP solver
 - Kantorovic