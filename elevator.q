//This file was generated from (Academic) UPPAAL 4.1.24 (rev. 29A3ECA4E5FB0808), November 2019

/*
PROP 7 -X-              --- 
\/* The time needed to serve a request is bounded by the product of the distance in 			*\/
\/* number of floors by the time needed to travel the distance of one floor plus twice the time it 	*\/
\/* takes to open or close the door. More formally the property is defined as follows. Let p be 		*\/
\/* the time to open or close the door. Let t be the time needed to cover the distance between two 	*\/
\/* is expressed as: 											*\/
\/* s \u2264 d \u00b7 t + 2 \u00b7 p 											*\/

*/
sup: ()

/*
PROP 6 -V- safety       --- 
\/* Whenever a request is served, the passengers will be able to leave the cabin *\/
\/* Every node that contains a served request, is followed by an opening door node before another request is served. *\/
*/
A[] (main_control(0).elevator_waiting imply cabin_door(0).open)

/*
PROP 5 -V- liveness     --- 

\/* All floor requests are eventually served, i.e., the elevator reaches its destination. *\/

\/* Liveness property: something will eventually happen. *\/
*/
(request_handler(0).enqueue_input && request_handler(0).current_req == 1) --> (main_control(0).stopped && current_floor[0] == 1)\
\
/*\
and the same goes for each floor and matching elevator:\
\
(request_handler(0).enqueue_input && request_handler(0).current_req == 2) --> (main_control(0).stopped && current_floor[0] == 2)\
 */

/*
PROP 4 -X-              --- 

\/* Each floor (except the ground floor) can be reached, and only by the correct elevator *\/

2 full days of searching for this. Nothing....
*/
A[] forall(f:int[1,N - 1]) forall(e:id_e) \
(\
	(current_floor[e] == f && main_control(e).stopped && request_handler(e).is_req_for_lift(f))\
	|| \
	(!request_handler(e).is_req_for_lift(f))\
	|| \
	(request_handler(e).is_req_for_lift(f))\
)

/*
PROP 3 -V- Reachability --- 

\/* IMPORTANT: because of the extra check of value_exists_in_queue() before acutally enqueueing, this ONLY works if the number of reachable floors >= the size of the queue. *\/
\/* This means: for a config of 6floors\/2lifts this will not work, as there are not enough floors per lift to fully populate a queue of length 5! *\/

\/* The amount of requests can reach the threshold value (in the description of Task 1 the value is 5) when the elevator is on the ground floor. *\/
\/* There exists a path where the elevator is on the ground floor and the amount of requests equals 5 *\/

*/
E<> (request_handler(0).len == request_handler(0).size and current_floor[0] == 0)\
\
/*\
repeat for every lift:\
E<> (request_handler(1).len == request_handler(1).size and current_floor[1] == 0)\
...\
*/

/*
PROP 2 -V- safety       --- 

\/* The elevator never travels with its door open. *\/
\/* safety property: something bad will never happen *\/
\/* OR IN UPPAAL - something good is invariantly true *\/

\/* The elevator always travels with its door closed. *\/
*/
A[] (main_control(0).moving imply cabin_door(0).closed)\
\
/*\
repeat for every lift:\
A[] (main_control(1).moving imply cabin_door(1).closed)\
...\
*/

/*
PROP 1 -V- safety?      --- 

\/* The elevator control unit is deadlock-free.*\/
*/
A[] not deadlock
