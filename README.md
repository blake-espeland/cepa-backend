# Cybernetic Economic Planning Agent (CEPA)  

## CEPA Server Application

Author: Blake Espeland

This project is a **work in progress**, and likely will be for a while. The backend will have to be finished, to a certain extent, prior to work on the forntend.

Currently contains the following components:
- Controller: Houses the necessary tools for manual and automated economic control. This component performs all of the necessary GPU calls as well. For now, the component is written in Julia, with tentatice plans to rewrite in C++ and Cuda.
- Backend: Brokers between the Controller and database

Future components:
[] Doctor: Manage faults and performance of the entire system. Likely one of the next components to get developed.
[] Translator: HAL for Julia to interact with. Support for NVidia, AMD, and Intel GPUs eventually
[] LoadManager: Manage request and resonse load. Plans to start development once frontend is complete.
[] Database: Plans for using PostgreSQL. Still need to work out requirements for schema.

### The database shall abide by the ACID principles
- Atomicity - A request happens at once or not at all.
- Consistency - The database must maintain consistency before and after a transaction.
- Isolation - Multiple requests can happen at the same time without interferrence (parallelism).
- Durability - The database carries on even after a failed request.

### Main goals of national economic planning
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
