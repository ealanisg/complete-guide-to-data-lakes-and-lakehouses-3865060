{% set nessie_branch = var('nessie_branch', 'main') %}

SELECT 
    s.id AS sale_id,
    c.first_name AS customer_name,
    v.model_name AS vehicle_model,
    s.sale_date,
    s.sale_price,
    s.payment_method
FROM {{ source('silver', 'sales') }} AT branch {{ nessie_branch }} s
LEFT JOIN {{ source('silver', 'vehicles') }} AT branch {{ nessie_branch }} v ON s.vehicle_id = v.id
LEFT JOIN {{ source('silver', 'customers') }} AT branch {{ nessie_branch }} c ON s.customer_id = c.id