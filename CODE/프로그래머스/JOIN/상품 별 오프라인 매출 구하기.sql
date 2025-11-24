SELECT product_code
      ,SUM(price * sales_amount)  SALES
FROM product p 
    JOIN offline_sale o
    ON p.product_id = o.product_id
GROUP BY product_code
ORDER BY SALES DESC, product_code ASC;