BEGIN;

SET client_encoding = 'LATIN1';

create schema private;

-- create table city
create table private.city (
    city__id integer not null primary key ,
    name text not null,
    countrycode character(3) not null,
    district text not null,
    population integer not null
);

-- insert some data
COPY private.city (city__id, name, countrycode, district, population) FROM stdin;
1	Kabul	AFG	Kabol	1780000
2	Qandahar	AFG	Qandahar	237500
3	Herat	AFG	Herat	186800
\.

-- create view
create view public.cities as select city__id as id, name, countrycode, district, population from private.city;

-- create trigger on view
create or replace function private.update_city() returns trigger as
$$
begin
    raise exception 'new.name = %, old.name=%, new.countrycode = %, old.countrycode = %', new.name, old.name, new.countrycode, old.countrycode;

    return new;
end;
$$ security definer language plpgsql;
alter function private.update_city() owner to anon;

create trigger city_update
    instead of update
    on public.cities
    for each row
execute procedure private.update_city();

COMMIT;

ANALYZE private.city;


