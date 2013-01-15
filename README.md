COS_323
=======

COS323 Disease Dynamics Final Project

This application was developed for COS323 at Princeton University as a final project to simulate the SZR model for zombie outbreaks. This program can be run by doing the following:

call the mainzombie.m function as follows:

>> [Su,Zo,S,Sui,Zoi] = mainzombie(N,T,Length,infected,ammo,randoammo,grapheron);

In the above function, there will be N zombies on a grid of Length X Length units, there will be infected% random infection rate, and we will be an amount ammo assigned to each user. If one wants to have random ammo assignment they should set the randoammo value to 1, true. Similiarlly if one does not which to display the graphing feature they can set grapheron to 0, false.

Calling the following script will allow the user to view across multiple iterations the dynamics of different properties in the system. So one could add a certain amount of ammo to determine how much ammo would need to be distributed to provide everyone with enough to survive the apocalypse.

>> [table] = zombieoptimizer(ammo)

A table will be returned containing the following for each run, in the following format:

[i Su Zo Sui Zoi]

Where i is the iteration step, and i * .05 will provide you with the level of infection, where Su is the number of survivors, Zo is the number of zombies remaining, and Sui is the initial count of survivors, where Zoi is also the initial count of Zombies. 

This program due to it's graphical nature is very memory and computationally intensive, for this project it was run on an AMD Phenom X6 machine with 16 GB of RAM.
