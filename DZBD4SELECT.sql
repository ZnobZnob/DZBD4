--1.количество исполнителей в каждом жанре;

SELECT g.name, count(*) 
FROM executor_genre eg
JOIN genre g 
ON g.id = eg.genre 
GROUP BY g.name
ORDER BY count(*) desc;

--2.количество треков, вошедших в альбомы 2019-2020 годов

SELECT a.name, COUNT(t.name) FROM album a
JOIN track t ON a.id = t.album_id
WHERE year BETWEEN 2019 AND 2020
GROUP BY a.name;

--3.средняя продолжительность треков по каждому альбому

SELECT a.name, avg(t.long) FROM album a
JOIN track t ON a.id = t.album_id
GROUP BY a.name
order by avg(t.long);

--4.все исполнители, которые не выпустили альбомы в 2020 году;

select e.name from executor e 
where e.name not in (
select e.name from executor e 
join executor_album ea on ea.executor = e.id 
join album a on a.id = ea.album 
where a.year = 2020);

--5.названия сборников, в которых присутствует конкретный исполнитель (выберите сами)

SELECT distinct c.name from track_complication tc 
join complitation c on tc.complitation = c.id 
join track t on t.id = tc.track 
join album a on a.id = t.album_id 
join executor_album ea on ea.album = a.id 
join executor e on e.id = ea.id 
where e.name like 'Queen';

--6.название альбомов, в которых присутствуют исполнители более 1 жанра

select a.name, count(eg.genre) from album a 
join executor_album ea on ea.album = a.id 
join executor e on e.id = ea.executor 
join executor_genre eg on eg.executor = e.id 
join genre g on g.id = eg.genre 
group by a.name
having count(eg.genre) != 1;

--7.наименование треков, которые не входят в сборники;

select t.name from track_complication tc 
full join track t on t.id = tc.track 
where complitation is null;

--8.исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)

select distinct e.name, t.long from track t 
join album a on a.id = t.album_id 
join executor_album ea on ea.album = a.id 
join executor e on e.id = ea.executor
where long = (
	select min(long) from track);

--9.название альбомов, содержащих наименьшее количество треков.

select a.name, count(t.name) from album a 
join track t  on t.album_id = a.id  
group by a.id
having count(t.name) = (
	select count(t.name) from album a
	join track t  on t.album_id = a.id
	group by a.id
	order by count(t.name)
	limit 1);
