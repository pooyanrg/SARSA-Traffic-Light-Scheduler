function [r, q1, q2, q3, q4] = reward(state, cycleTime, delta, S, flow)
r = 0;
queue1(1) = 0;
queue2(1) = 0;
queue3(1) = 0;
queue4(1) = 0;
i = state;
f1 = max(flow(i, 1), flow(i, 3));
f2 = max(flow(i, 2), flow(i, 4));
greenTime1 = f1 * cycleTime / (flow(i, 1) + flow(i, 3));
greenTime2 = f2 * cycleTime / (flow(i, 2) + flow(i, 4));
max_iter = floor(3600 / cycleTime);

for iter = 1:max_iter
    queue1(iter + 1) =  delta(1) * queue1(iter) - greenTime1 * (delta(1) * S(1) + (1 - delta(1)) * flow(i, 1)) + greenTime2 * flow(i, 1);
    queue2(iter + 1) =  delta(2) * queue2(iter) - greenTime2 * (delta(2) * S(2) + (1 - delta(2)) * flow(i, 2)) + greenTime1 * flow(i, 2);
    queue3(iter + 1) =  delta(3) * queue3(iter) - greenTime1 * (delta(3) * S(3) + (1 - delta(3)) * flow(i, 3)) + greenTime2 * flow(i, 3);
    queue4(iter + 1) =  delta(4) * queue4(iter) - greenTime2 * (delta(4) * S(4) + (1 - delta(4)) * flow(i, 4)) + greenTime1 * flow(i, 4);
    
    if queue1(iter + 1) > 0
        delta(1) = 1;
    else
        delta(1) = 0;
    end
    
    if queue2(iter + 1) > 0
        delta(2) = 1;
    else
        delta(2) = 0;
    end
    
    if queue3(iter + 1) > 0
        delta(3) = 1;
    else
        delta(3) = 0;
    end
    
    if queue4(iter + 1) > 0
        delta(4) = 1;
    else
        delta(4) = 0;
    end
end
r = r - queue1(iter + 1) - queue2(iter + 1) - queue3(iter + 1) - queue4(iter + 1);
q1 = queue1(iter + 1);
q2 = queue2(iter + 1);
q3 = queue3(iter + 1);
q4 = queue4(iter + 1);
end