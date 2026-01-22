select * from trip_data td limit 5;

select * from zones z ;

-- Question 3. Counting short trips
-- For the trips in November 2025 (lpep_pickup_datetime
--	between '2025-11-01' and '2025-12-01', exclusive of the upper bound), how many trips had a trip_distance of less than or equal to 1 mile?

select count(1) from trip_data td 
where td.lpep_pickup_datetime between '2025-11-01' and '2025-12-01'
and td.trip_distance <= 1;


-- Question 4. Longest trip for each day
-- Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles (to exclude data errors).
select td.trip_distance , td.lpep_pickup_datetime  from trip_data td 
where td.trip_distance < 100
order by td.trip_distance desc
limit 1;


-- Question 5. Biggest pickup zone
-- Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?
select z."Zone", sum(td.total_amount) largest_total_amount from trip_data td 
join zones z on td."PULocationID" = z."LocationID" 
where date(td.lpep_pickup_datetime) = date('2025-11-01')
group by z."Zone"
order by largest_total_amount desc
limit 1;




-- Question 6. Largest tip
-- For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?
-- Note: it's tip , not trip. We need the name of the zone, not the ID.

select z."Zone", td.tip_amount  from trip_data td 
join zones z on td."DOLocationID" = z."LocationID" 
where td."PULocationID" = (
	select z2."LocationID" from zones z2 
	where z2."Zone" = 'East Harlem North'
	)
order by td.tip_amount desc;


