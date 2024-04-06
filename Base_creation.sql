create schema project

drop table if exists project.sights cascade

create table project.sights (
  id serial primary key,
  name varchar(256),
  type varchar(256)
)

alter table project.sights
add check(type = 'museum' or type = 'sculpture' 
or type = 'cathedral' or type = 'reserve')

drop table if exists project.location cascade

create table project.location (
  id serial primary key,
  country varchar(256) not null,
  city varchar(256) not null,
  constraint fk foreign key(id) references project.sights(id)
)

drop table if exists project.Geographical_coordinates

create table project.Geographical_coordinates (
  id serial primary key,
  latitude double precision not null,
  city double precision not null,
  constraint fk foreign key(id) references project.sights(id)
)

drop table if exists project.contacts cascade

create table project.contacts (
  id serial primary key,
  phone_number varchar(20),
  site varchar(256),
  fax varchar(256),
  constraint fk foreign key(id) references project.sights(id)
)

drop table if exists project.People cascade

create table project.People (
  id serial primary key,
  Pioneer varchar(256),
  keeper varchar(256),
  sponsor varchar(256),
  guest varchar(256),
  constraint fk foreign key(id) references project.sights(id)
)

drop table if exists project.General_information cascade

create table project.General_information (
  id serial primary key,
  open_time time with time zone default '00:00:00.0+00',
  close_time time with time zone default '00:00:00.0+00',
  start_dinner time with time zone default '00:00:00.0+00',
  end_dinner time with time zone default '00:00:00.0+00',
  ticket_cost money default 0, 
  constraint fk foreign key(id) references project.sights(id)
)

drop table if exists project.chronology cascade

create table project.chronology (
  id serial primary key,
  foundation_date date not null,
  add_to_UNESCO date,
  constraint fk foreign key(id) references project.sights(id)
)
