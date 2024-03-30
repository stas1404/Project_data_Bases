-- Выбрать 25 стран с самым большим количеством достопримечательноcтей
select country, count(*) as amount
from project.location
group by country
order by amount
limit 25

-- Выбрать 25 самых дорогих достопримечательноcтей
select name, ticket_cost
from project.sights as s
join project.General_information as g
on s.id = g.id
order by ticket_cost desc
limit 25

--Выбрать 25 наиболее близких для заданных координат достопримечательснотей
select name, latitude, longtitude ,ticket_cost
from project.sights as s
join project.Geographical_coordinates as Geocoord
on Geocoord.id = s.id
join project.General_information as g
on s.id = g.id
where latitude between 52 and 54 and longtitude between 30 and 31
order by ticket_cost asc
limit 25

-- Группируем страны по названию и выводим процент от общего числа достопримечательностей для каждой в Порядке убывания
with am as(
  select count(*) as sum
  from project.sights
)
select country, count(*) * 100.0 / max(am.sum) as percentage
from project.location , am
group by country
order by percentage


--Выбираем достопримечательсноти которые закрываются после 22:00 По Москве
select name, type
from project.sights
where exists (
  select pioneer
  from project.People
  where project.People.id = project.sights.id
)
and project.sights.id in (
  select id 
  from project.general_information gi 
  where gi.close_time > '22:00:00+03'
)

--Узнайм , сколько надо денег, чтобы посетить все достопримечательности России
select sum(ticket_cost)
from project.general_information
where id in (
  select id
  from project.location
  where country = 'Россия'
)

--Получаем все достопримечательсноти , построенные до 1325 года

select name, foundation_date
from project.sights 
join project.chronology
on project.sights.id = project.chronology.id
where  foundation_date between date('01.01.0001') and date('12.31.1325')

--Получаем самую старую достопримечательность

select name, foundation_date
from project.sights 
join project.chronology
on project.sights.id = project.chronology.id
order by foundation_date asc
limit 1

--Получаем все достопримечательсноти у которых есть официальный сайт

select name, site
from project.sights 
join project.contacts
on project.sights.id = project.contacts.id
where site is not null

