-- If you like Python data type hints, you might like SQL domains
-- github.com/sqlxpert/data-types-sql-domain-postgresql-operator
-- GPLv3, Copyright Paul Marcelin



-- county and city name example
-- postgresql 18



-- should be  place_name etc. but screen width is limited!
create domain place  as varchar 
                     -- varchar(maximum length) except in postgresql
  constraint place_not_null       check (value is not null)

  constraint place_length_minimum check ( 2 <= length(value)      )
  constraint place_length_maximum check (      length(value) <= 25)
  -- potentially easier to increase allowed length by editing a constraint

  constraint place_space_trimmed  check (value = trim(both from value))
  constraint place_lowercase      check (value = lower(value))
;
create domain county as place;
create domain city   as place;


create function county_city_never_equal(county, city)
  returns boolean

  immutable
  leakproof
  strict
  security invoker
  parallel safe

  language sql
  return false
;

create function county_city_never_equal(city, county)
  returns boolean

  immutable
  leakproof
  strict
  security invoker
  parallel safe

  language sql
  return false  -- more complex? call the other function with inputs reversed!
;

create operator   = (
   commutator =   =
  ,leftarg    = county
  ,rightarg   = city
  ,function   = county_city_never_equal
);

create operator   = (
   commutator =   =
  ,leftarg    = city
  ,rightarg   = county
  ,function   = county_city_never_equal
);

select
   cast('alameda' as varchar)  = cast('alameda' as varchar) as string_eq
  ,cast('alameda' as county )  = cast('alameda' as county ) as county_eq
  ,cast('alameda' as city   )  = cast('alameda' as city   ) as city_eq
  ,cast('alameda' as county )  = cast('alameda' as city   ) as county_eq_city
  ,cast('alameda' as city   )  = cast('alameda' as county ) as city_eq_county
;
