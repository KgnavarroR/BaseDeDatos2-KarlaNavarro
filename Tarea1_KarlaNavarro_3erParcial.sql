--Karla Gabriela Navarro Raudales     20191003134        Sección: 0800 L-J

--Ejercicio # 1
SELECT name, gender, SUM(number) sumatoria_number
FROM `bigquery-public-data.usa_names.usa_1910_2013`        
GROUP BY name, gender
ORDER BY SUM(number) DESC


--Ejercicio #2
SELECT date, state, tests_total, cases_positive_total, SUM(tests_total) OVER(PARTITION BY state) suma_total
FROM `bigquery-public-data.covid19_covidtracking.summary` 


--Ejercico #3
WITH Datos AS (
SELECT channelGrouping, SUM(totals.pageviews) pageviews FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801` 
GROUP BY channelGrouping
)

SELECT Datos.channelGrouping, Datos.pageviews, (Datos.pageviews/SUM(Datos.pageviews)OVER()) porcentaje_del_total, AVG(Datos.pageviews)OVER() promedio FROM Datos
GROUP BY Datos.channelGrouping, Datos.pageviews
ORDER BY porcentaje_del_total DESC


--Ejercicio #4
SELECT Region, Country, Total_Revenue, DENSE_RANK() OVER(PARTITION BY Region ORDER BY Total_Revenue DESC) rank
FROM `tarea1-karlanavarro.dataset.Ventas`       