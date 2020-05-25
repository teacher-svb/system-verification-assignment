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
//NO_QUERY

/*

*/
//NO_QUERY

/*
PROP 6 --- safety       --- 
\/* Whenever a request is served, the passengers will be able to leave the cabin *\/
\/* Every node that contains a served request, is followed by an opening door node before another request is served. *\/
*/
//NO_QUERY

/*
 - PROP 6 - elevator 0
*/
/* elevator 0 */\
\
A[] (main_control(0).elevator_waiting imply cabin_door(0).open)

/*
 - PROP 6 - elevator 1
*/
/* elevator 1 */\
\
A[] (main_control(1).elevator_waiting imply cabin_door(1).open)

/*

*/
//NO_QUERY

/*
PROP 5 --- liveness     --- 

\/* All floor requests are eventually served, i.e., the elevator reaches its destination. *\/

\/* Liveness property: something will eventually happen. *\/
*/
//NO_QUERY

/*
 - PROP 5 - floor 1
*/
/*floor 1 gets elevator 0 */\
\
(request_handler(0).enqueue_input && request_handler(0).current_req == 1) --> (main_control(0).stopped && current_floor[0] == 1)\


/*
 - PROP 5 - floor 2
*/
/*floor 2 gets elevator 0 */\
\
(request_handler(0).enqueue_input && request_handler(0).current_req == 2) --> (main_control(0).stopped && current_floor[0] == 2)\


/*
 - PROP 5 - floor 3
*/
/*floor 3 gets elevator 0 */\
\
(request_handler(0).enqueue_input && request_handler(0).current_req == 3) --> (main_control(0).stopped && current_floor[0] == 3)\


/*
 - PROP 5 - floor 4
*/
/*floor 4 gets elevator 1 */\
\
(request_handler(1).enqueue_input && request_handler(1).current_req == 4) --> (main_control(1).stopped && current_floor[1] == 4)\


/*
 - PROP 5 - floor 5
*/
/*floor 5 gets elevator 1 */\
\
(request_handler(1).enqueue_input && request_handler(1).current_req == 5) --> (main_control(1).stopped && current_floor[1] == 5)\


/*

*/
//NO_QUERY

/*
PROP 4 --- safety       --- 

\/* Each floor (except the ground floor) can be reached, and only by the correct elevator *\/

\/* The two most horrible days of these past few weeks were spent looking for this. *\/

*/
A[]\
(\
	forall(f:id_f)\
	(\
		(exists(e:id_e) (request_handler(e).is_req_for_lift(f)))\
		and\
		(target_floor == f imply exists(e:id_e)(request_handler(e).is_req_for_lift(f)))\
		or \
		f == 0\
	)\
)

/*

*/
//NO_QUERY

/*
PROP 3 --- Reachability --- 

\/* The amount of requests can reach the threshold value (in the description of Task 1 the value is 5) when the elevator is on the ground floor. *\/
\/* There exists a path where the elevator is on the ground floor and the amount of requests equals 5 *\/

*/
//NO_QUERY

/*
 - PROP 3 - elevator 0
*/
E<> \
(\
	request_handler(0).len == request_handler(0).size\
	and \
	current_floor[0] == 0\
)

/*
 - PROP 3 - elevator 1
*/
E<> \
(\
	request_handler(1).len == request_handler(1).size\
	and \
	current_floor[0] == 0\
)

/*

*/
//NO_QUERY

/*
PROP 2 --- safety       --- 

\/* The elevator never travels with its door open. *\/
\/* safety property: something bad will never happen *\/
\/* OR IN UPPAAL - something good is invariantly true *\/

\/* The elevator always travels with its door closed. *\/
*/
//NO_QUERY

/*
 - PROP 2 - elevator 0
*/
/* elevator 0 */\
\
A[] (main_control(0).moving imply cabin_door(0).closed)\


/*
 - PROP 2 - elevator 1
*/
/* elevator 1 */\
\
A[] (main_control(1).moving imply cabin_door(1).closed)\


/*

*/
//NO_QUERY

/*
PROP 1 -V- safety?      --- 

\/* The elevator control unit is deadlock-free.*\/
*/
A[] not deadlock
