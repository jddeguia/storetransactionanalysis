## Data Cleaning
- there are values that we think is better to set all the strings to UPPERCASE
- `stg_dim_devices` and `stg_dim_store` is joined to create `stg_dim_stores_with_devices`. This was done to enable us joining it to transaction table `stg_fct_transactions`
- `mart_fct_store_transactions` is derived from `stg_fct_transactions`. This lists down all of the columns that we will need to answer specific questions. This is like our one big table to be derived by mart models
  
## Results 
### Top 10 stores per transacted amount
This can be answered by `mart_dim_store_transacted_amounts`
We assumed that the transaction status is `ACCEPTED`
This was determined by aggregating the store with the sum of total transacted amount in euros
Here are the top 10 stores aggregated by transacted amount


![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/c266a2c4-e6ec-4233-93b9-8d9f417fb420)

### Top 10 products sold
This can be answered by `mart_dim_products_sold`
We assumed that the transaction status is `ACCEPTED`
This was determined by aggregating the store with the count of transaction id.
However, we can also answer the question such as top 10 product per transacted amount
Here are the top 10 stores aggregated 


![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/42ff1555-565e-428c-a93b-b7303ad425a5)

### Average transacted amount per store typology and country
This can be answered by both `mart_dim_average_transacted_amount_store_typology` and `mart_dim_average_transacted_amount_store_country`
We aggregate store typology and store country by the average transacted amount (the results are saved on different models)
We assumed that the transaction status is `ACCEPTED`

Average transacted amount by store typology

![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/8c3c97c5-99dd-47bb-a869-a91e2ed75e53)

Average transacted amount by store country

![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/1a08b330-d627-4cd8-8108-c993b3bd5211)

### Percentage of transactions per device type
This can be answered by `mart_dim_transaction_percentage_per_device_type`
We assumed that the transaction status is `ACCEPTED`

![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/43ea2152-d386-455a-b56d-3ef8abc41068)

### Average time for a store to perform its 5 first transactions

This is answered by `mart_dim_average_transaction_time_performance`
To answer this question, we get the time difference between `transaction_created_at` and `transaction_happened_at`
Assuming that `transaction_created_at` is the timestamp where the transaction is created
and `transaction_happened_at` is the timestamp where the transaction has actually happened

We get the first 5 timestamp difference and average it on the next CTE

Here is the result

![image](https://github.com/jddeguia/storetransactionanalysis/assets/70092528/e2913813-e466-4768-9ce1-8555c9c411cd)

## Insights
- Nec Ante Ltd has the most transacted amount in euros (assuming the transaction is a success)
- The product name SITAMET GRAVIDA has the most transaction (from the given dataset) however it doesn't have the highest transacted amount. INCEPTOSHYMENAEOUS QUIS has the highest transacted amount
- Hotel has the highest average transacted amount in euros while foodtruck has the lowest
- If the store country is located in Vietnam, it has the highest average transacted amount. The lowest is in Chile
- Device number 4 has the most contribution in making a transaction, while number 2 has the lowest
- Neque Tellus PC has the quickest time to make a transaction
