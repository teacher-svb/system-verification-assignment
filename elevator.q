//This file was generated from (Academic) UPPAAL 4.1.24 (rev. 29A3ECA4E5FB0808), November 2019

/*
\/* The time needed to serve a request is bounded by the product of the distance in 			*\/
\/* number of floors by the time needed to travel the distance of one floor plus twice the time it 	*\/
\/* takes to open or close the door. More formally the property is defined as follows. Let p be 		*\/
\/* the time to open or close the door. Let t be the time needed to cover the distance between two 	*\/
\/* is expressed as: 											*\/
\/* s \u2264 d \u00b7 t + 2 \u00b7 p 											*\/

*/
//NO_QUERY

/*
\/* Whenever a request is served, the passengers will be able to leave the cabin *\/
\/* Every node that contains a served request, is followed by an opening door node before another request is served. *\/
*/
//NO_QUERY

/*
\/* All floor requests are eventually served, i.e., the elevator reaches its destination. *\/

\/* Liveness property: something will eventually happen. *\/
*/
//NO_QUERY

/*
\/* Each floor (except the ground floor) can be reached, and only by the correct elevator *\/
\/* reachability property *\/


E<>forall(f:int[1,N-1]) forall(e:id_e) (e == (f-1)\/num_floors_per_elevator imply protecting_door(f,e).open)

E<> (0 == (1-1)\/num_floors_per_elevator imply protecting_door(1,0).open)
E<> (1 == (1-1)\/num_floors_per_elevator imply protecting_door(1,1).open)

E<> (0 == (2-1)\/num_floors_per_elevator imply protecting_door(2,0).open)
E<> (1 == (2-1)\/num_floors_per_elevator imply protecting_door(2,1).open)

E<> (0 == (3-1)\/num_floors_per_elevator imply protecting_door(3,0).open)
E<> (1 == (3-1)\/num_floors_per_elevator imply protecting_door(3,1).open)

E<> (0 == (4-1)\/num_floors_per_elevator imply protecting_door(4,0).open)
E<> (1 == (4-1)\/num_floors_per_elevator imply protecting_door(4,1).open)

E<> (0 == (5-1)\/num_floors_per_elevator imply protecting_door(5,0).open)
E<> (1 == (5-1)\/num_floors_per_elevator imply protecting_door(5,1).open)
*/
\
E<>forall(f:int[1,N-1]) forall(e:id_e) (e == (f-1)/num_floors_per_elevator imply protecting_door(f,e).open)

/*
\/* The amount of requests can reach the threshold value (in the description of Task 1 the value is 5) when the elevator is on the ground floor. *\/
\/* There exists a path where the elevator is on the ground floor and the amount of requests equals 5 *\/

\/* Reachablility property *\/
*/
E<> (fifo_RequestHandler(0).len == fifo_RequestHandler(0).size and current_floor[0] == 0)

/*
\/* The elevator never travels with its door open. *\/
\/* safety property: something bad will never happen *\/
\/* OR IN UPPAAL - something good is invariantly true *\/

\/* The elevator always travels with its door closed. *\/
*/
A[] (dummy_MainControl(0).moving imply cabin_door(0).closed)

/*
\/* The elevator control unit is deadlock-free.*\/
*/
A[] not deadlock
