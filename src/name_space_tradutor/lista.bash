 mysql --host database -u xxx --password="xxx" wikidb -BNe "
 SELECT
   CASE
     WHEN page_namespace = 0 THEN REPLACE(page_title, '_', ' ')
     ELSE CONCAT(REPLACE(n.ns_name, '_', ' '), ':', REPLACE(page_title, '_', ' '))
   END AS full_title
 FROM page p
 LEFT JOIN \`namespace\` n ON p.page_namespace = n.ns_id
 WHERE
   p.page_is_redirect = 0
   AND p.page_namespace NOT IN (-2, -1, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
 ORDER BY full_title;" > ~/pages_to_process.txt
 mysql --host database -u root --password="baEdejELp5ozg" wikidb -BNe "
 SELECT
   CASE p.page_namespace
     WHEN 0 THEN REPLACE(p.page_title, '_', ' ')
     WHEN 1 THEN CONCAT('Talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 2 THEN CONCAT('User:', REPLACE(p.page_title, '_', ' '))
     WHEN 3 THEN CONCAT('User talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 4 THEN CONCAT('Project:', REPLACE(p.page_title, '_', ' '))
     WHEN 5 THEN CONCAT('Project talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 6 THEN CONCAT('File:', REPLACE(p.page_title, '_', ' '))
     WHEN 7 THEN CONCAT('File talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 8 THEN CONCAT('MediaWiki:', REPLACE(p.page_title, '_', ' '))
     WHEN 9 THEN CONCAT('MediaWiki talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 10 THEN CONCAT('Template:', REPLACE(p.page_title, '_', ' '))
     WHEN 11 THEN CONCAT('Template talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 12 THEN CONCAT('Help:', REPLACE(p.page_title, '_', ' '))
     WHEN 13 THEN CONCAT('Help talk:', REPLACE(p.page_title, '_', ' '))
     WHEN 14 THEN CONCAT('Category:', REPLACE(p.page_title, '_', ' '))
     WHEN 15 THEN CONCAT('Category talk:', REPLACE(p.page_title, '_', ' '))
     -- Adicione outros namespaces customizados aqui se souber o ID e o nome:
     -- WHEN 100 THEN CONCAT('Doc:', REPLACE(p.page_title, '_', ' '))
     ELSE CONCAT(p.page_namespace, ':', REPLACE(p.page_title, '_', ' '))
   END AS full_title
 FROM page p
 WHERE
   p.page_is_redirect = 0
   AND p.page_namespace NOT IN (-2, -1, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
 ORDER BY full_title;" > ~/pages_to_process.txt
