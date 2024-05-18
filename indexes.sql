-- Географические кооржинаты точно не изменятся, 
-- могут лишь изредка добавляться новые достопримечательности
create index Geographical_idx on 
project.Geographical_coordinates(latitude,  longtitude);

-- Cитуация как с Географичискеми координатами                              
create index sights_idx on 
project.sights(name, type);

-- Cитуация как с Географичискеми координатами    
create index chronology_idx on 
project.chronology(foundation_date);
 
