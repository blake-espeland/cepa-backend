* Cybernetic Economic Planning Agent (CEPA)  

** Library for the backend to the CEPA  

Author: Blake Espeland

The frontend to this project is a work in progress. The backend will have to be finished, to a certain extent, prior to work on the forntend.

Contains the following components:
- DataBroker: Processes control requests into database requests and responses.
- NetBroker: Processes raw frontend requests, sends data to Controller.
- Simulator: Bypass the NetBroker and frontend, and send simulated requests to the Controller. This component acts as a replacement for the real world inputs received from the "sensory organs" on the frontend.
- Controller: Houses the necessary tools for manual and automated economic control.

Future components:
- Doctor: Manage faults and performance of the entire system.
- LoadManager: Manage request and resonse load.

*The database shall abide by the ACID principles:*
Atomicity - A request happens at once or not at all.
Consistency - The database must maintain consistency before and after a transaction.
Isolation - Multiple requests can happen at the same time without interferrence (parallelism).
Durability - The database carries on even after a failed request.

*Main goals of (socialist) economic planning*
1. Shorten work week for all. Since value is represented in terms of labor hours, there will be an
incentive to reduce the amount of working hours required to complete projects and produce products.
2. Place ecological and humanitarian constraints on production. Since profit is not the primary
motive of socialist production, there can be far more beneficial constraints and incentives placed
on industry.
3. Production for people and planet, not profit.
4. Flexibiilty. A computerized planning system allows for ultimate flexibility when planning. The
shear amount of information available to planners helps make more informed decisions.
5. Democratic planning. Everyone is a planner when everyone has an entrypoint into the planning
software.

See Paul Cockshott's work on cybernetic planning.
See Tomas Haerdin's work on cybernetic planning.

See the list of active issues for a comprehensive overview of the required tasks.
