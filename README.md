# About

The inspiration for this repository was one of the most interesting interview 
questions I've had. It perfectly illustrates the tradeoffs between arrays and 
linked lists. (That's a hint, btw.) It appears very simple on the surface, yet 
it's trickier than it seems. Here's the question:

There are an arbitrary number of asteroids. Some are moving towards you, and 
some are moving away from you. For simplicity, let's assume that some asteroids 
are moving leftward (away from you) and some are moving rightward (towards you).

Each asteroid has a weight, represented numerically (without units). When two 
adjacent asteroids collide, the asteroid of greater weight destroys the 
asteroid of smaller weight. The asteroid of greater weight's direction and 
weight do not change after the collision. (We ignore conservation of momentum).

Asteroids collide only when they are adjacent and moving towards each other.

Here's an example. Each asteroid is represented by a number indicating its 
weight, and an arrow indicating its direction.

3 9 4 2 6 7 8

< > < > > < >

After all collisions, we have the following asteroids remaining:

3 9 8

< > >

(All other asteroids were eliminated in the collisions.)

**Write code to count the number of asteroids moving towards you (rightward) 
after all collisions. Try to come up with a solution that always runs in O(n) 
time.**


The code in this repository implements two solutions to the problem. One runs 
in O(n ** 2) time, and the other runs in O(n) time.
