-- от узла 6 до корня
WITH RECURSIVE plan AS 
(SELECT id , parentid, name FROM plants
WHERE id=6
UNION ALL
SELECT c.id, c.parentid, c.name
 FROM plan p, plants c
 WHERE c.id = p.parentid)
 SELECT * FROM plan;
 
 
-- потомки узла 6
WITH RECURSIVE plan AS 
(SELECT id , parentid, name FROM plants
WHERE parentid=3
UNION ALL
SELECT c.id, c.parentid, c.name
 FROM plan p, plants c
 WHERE c.parentid = p.id)
 SELECT * FROM plan;
 
-- всё дерево
WITH RECURSIVE plan AS 
(SELECT id , parentid, name FROM plants
WHERE parentid is NULL
UNION ALL
SELECT c.id, c.parentid, c.name
 FROM plan p, plants c
 WHERE c.parentid = p.id)
 SELECT * FROM plan;