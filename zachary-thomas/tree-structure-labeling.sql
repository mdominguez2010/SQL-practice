/*
https://quip.com/2gwZArKuWk7W
node    parent
1       2
2       5
3       5
4       3
5       NULL

                            5
                          /   \
                         2     3
                        /        \
                       1          4
objective: label each node as either "leaf", "inner" or "Root" 
depth = 2
*/
WITH join_table AS
(
    SELECT
        a.node AS a_node,
        a.parent AS a_parent,
        b.node AS b_node,
        b_parent AS b_parent
    FROM
        tree a
    LEFT JOIN
        tree b ON a.parent = b.node
)

 SELECT 
    a_node node, 
    CASE 
        WHEN b_node IS NULL and b_parent IS NULL THEN 'Root'
        WHEN b_node IS NOT NULL and b_parent IS NOT NULL THEN 'Leaf'        
        ELSE 'Inner' 
    END AS label 
 FROM 
    join_table;
