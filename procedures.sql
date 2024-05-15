-- По заданным координатам и , возможно, расстоянию, 
-- получаем ближайшие достопримечательнсоти (их id)

create function Get_sights_id_in_within(client_latitude double precision,
                                        client_longtitude double precision,
                                        distance double precision default 1.0)
returns table(id bigint)
as $$
         select id
         from project.Geographical_coordinates g
         where g.latitude between  client_latitude - distance and client_latitude + distance
   $$
 language sql
 
-- По заданным координатам и , возможно, расстоянию, 
-- получаем ближайшие самые старые достопримечательнсоти (их id)

create function Get_mostly_old_sights_id_in_within(client_latitude double precision,
                                        client_longtitude double precision,
                                        distance double precision default 1.0)
returns table(id bigint)
as $$
         with timed as (select g.id, cg.foundation_date
         from Get_sights_id_in_within(client_latitude, client_longtitude, distance) g
         join project.chronology cg
         on g.id = cg.id)
         select m.id
         from timed m
         where m.foundation_date = (select min(m.foundation_date)
                                    from timed m)
   $$
 language sql

--Получаем все достопримечательности, которые сейчас открыты
create function Get_sights_id_open_now()
returns table(id bigint)
as $$
     select id 
     from project.General_information g
     where localtime  between g.open_time and g.close_time
   $$
 language sql
 
select * from  Get_sights_id_open_now()
