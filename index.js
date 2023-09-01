const { Client: PGClient } = require('pg');
const client = new PGClient({
    host: "localhost",
    user: "postgres",
    port: 5432,
    password: "2003",
    database: "project"
});

client.connect();
client.query(`select * from order_detail where status_name = 'pending' `, (err, res) => {
    if (!err)
        console.log(res.rows);
    else
        console.log(err.message);
    client.end();
});

const getCategorybyID= (request, response) => {

    const id = parseInt(request.params.id)
    
     
    
    pool.query('select product.product_id, product.name, product.rate_star from product join category using (category_id) where category_id = $1 order by rate_star desc limit 1;', 
    [id], (error, results) => {
    
    if (error) {
    
    throw error
    
    }
    
    response.status(200).json(results.rows)
    
    })
    
}

client.query(`select orders.order_id, total_money, orders.status_id
from orders join order_detail using (order_detail_id)
where orders.user_id = 1
order by order_detail.total_money desc`,(err,res) =>{
    
    if (!err)
    
    console.log(res.rows);
    
    else
    
    console.log(err.message);
    
    client.end;
    
    })