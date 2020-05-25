//This file was generated from (Academic) UPPAAL 4.1.24 (rev. 29A3ECA4E5FB0808), November 2019

/*
PROP 7 -X-              --- 
\/* The time needed to serve a request is bounded by the product of the distance in 			*\/
\/* number of floors by the time needed to travel the distance of one floor plus twice the time it 	*\/
\/* takes to open or close the door. More formally the property is defined as follows. Let p be 		*\/
\/* the time to open or close the door. Let t be the time needed to cover the distance between two 	*\/
\/* floors. Let s be the service time. Let d be the distance in number of floors. Then, the property     *\/
\/* is expressed as: 											*\/
\/* s \u2264 d \u00b7 t + 2 \u00b7 p 											*\/

e.g.

1: request floor 2
2: request floor 3
3: request floor 1
4: deuren toe
5: lift beweegt
6: deuren open
7: request floor 2 served
8: deuren toe
9: lift beweegt
10: deuren open
11: request floor 3 served
12: deuren toe
13: lift beweegt
14: lift beweegt
15: deuren open
16: request floor 1 served
17: deuren toe
...

t en p kan je opmaken uit je model
clock wordt reset\/gestart op 4, 8, 12, ..., sla hier d op als: abs(eindvloer - startvloer)
clock wordt gestopt op 7, 11, 16, ..., sla hier de waarde van de clock op in s

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

*/
//NO_QUERY

/*
PROP 4 --- safety       --- 

\/* IMPORTANT: this property will no longer work due to scalability improvements. This is due to how is_req_for_lift has changed: the comparison calculations have been moved to an initialisation function that is called at the start of the request_handler model. This means that at the early beginnings, before any requests can be made, is_req_for_lift won't work, breaking this propertys code. *\/

\/* Each floor (except the ground floor) can be reached, and only by the correct elevator *\/

\/* The two most horrible days of these past few weeks were spent looking for this. *\/

with forall\/exists:

A[]
(
	forall(f:id_f)
	(
		(
			(exists(e:id_e) (request_handler(e).is_req_for_lift(f)))
			and
			(target_floor == f imply exists(e:id_e)(request_handler(e).is_req_for_lift(f)))
		)
		or
		f == 0
	)
)
*/
/* IMPORTANT: this property will no longer work due to scalability improvements. (see comments for more details) */\
\
A[]\
(\
	(\
		(\
			(request_handler(0).is_req_for_lift(1))\
			and\
			(target_floor == 1 imply ((request_handler(0).is_req_for_lift(1)) and (!request_handler(1).is_req_for_lift(1))))\
		)\
	)\
	and\
	(\
		(\
			(request_handler(1).is_req_for_lift(2))\
			and\
			(target_floor == 2 imply ((request_handler(1).is_req_for_lift(2)) and (!request_handler(0).is_req_for_lift(2))))\
		)\
	)\
)

/*

*/
A[]\
(\
	(\
		(\
			((request_handler(0).is_req_for_lift(1)) or (request_handler(1).is_req_for_lift(1)))\
			and\
			(target_floor == 1 imply ((request_handler(0).is_req_for_lift(1)) or (request_handler(1).is_req_for_lift(1))))\
		)\
	)\
	and\
	(\
		(\
			((request_handler(0).is_req_for_lift(2)) or (request_handler(1).is_req_for_lift(2)))\
			and\
			(target_floor == 2 imply ((request_handler(0).is_req_for_lift(2)) or (request_handler(1).is_req_for_lift(2))))\
		)\
	)\
	and\
	(\
		(\
			((request_handler(0).is_req_for_lift(3)) or (request_handler(1).is_req_for_lift(3)))\
			and\
			(target_floor == 3 imply ((request_handler(0).is_req_for_lift(3)) or (request_handler(1).is_req_for_lift(3))))\
		)\
	)\
)

/*
PROP 3 --- Reachability --- 

\/* IMPORTANT: because of the extra check of value_exists_in_queue() before acutally enqueueing, this is not valid for model where the number of floors per elevator are fewer than 5. *\/

\/* The amount of requests can reach the threshold value (in the description of Task 1 the value is 5) when the elevator is on the ground floor. *\/
\/* There exists a path where the elevator is on the ground floor and the amount of requests equals 5 *\/

*/
/* IMPORTANT: this property will no longer work due to scalability improvements. (see comments for more details) */\
\


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
