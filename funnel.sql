WITH funnels AS (
  SELECT DISTINCT b.browse_date,
     b.user_id,
     c.user_id IS NOT NULL AS 'is_checkout',
     p.user_id IS NOT NULL AS 'is_purchase'
  FROM browse AS 'b'
  LEFT JOIN checkout AS 'c'
    ON c.user_id = b.user_id
  LEFT JOIN purchase AS 'p'
    ON p.user_id = c.user_id)
SELECT COUNT(*) AS 'num_browse', SUM(is_checkout) AS 'checkout', SUM(is_purchase) AS 'purchase', ROUND(100.0 * SUM(is_checkout) / COUNT(user_id), 2) AS '% checked out', ROUND(100.0 * SUM(is_purchase) / SUM(is_checkout), 2) AS '% purchased'
FROM funnels;
