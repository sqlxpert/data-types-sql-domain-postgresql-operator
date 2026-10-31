-- If you like Python data type hints, you might like SQL domains
-- github.com/sqlxpert/data-types-sql-domain-postgresql-operator
-- GPLv3, Copyright Paul Marcelin



-- money value versus interest rate example
-- postgresql 18



create domain money_portable as numeric(14, 2)
  constraint money_portable_not_null check (value is not null)
;

create domain interest_rate  as numeric( 5, 5)
  constraint interest_rate_not_null  check (value is not null)

  constraint interest_rate_minimum   check (0 <= value)
;



create function money_interest_never_equal(money_portable, interest_rate)
  returns boolean

  immutable
  leakproof
  strict
  security invoker
  parallel safe

  language sql
  return false
;

create function money_interest_never_equal(interest_rate, money_portable)
  returns boolean

  immutable
  leakproof
  strict
  security invoker
  parallel safe

  language sql
  return false
;

create operator   = (
   commutator =   =
  ,leftarg    = money_portable
  ,rightarg   = interest_rate
  ,function   = money_interest_never_equal
);

create operator   = (
   commutator =   =
  ,leftarg    = interest_rate
  ,rightarg   = money_portable
  ,function   = money_interest_never_equal
);

select
   cast(  0.05 as numeric(14, 2)) = cast(  0.05 as numeric( 5, 5)) as numeric_eq_numeric
  ,cast(  0.05 as money_portable) = cast(  0.05 as interest_rate ) as money_eq_interest
;



create or replace function add_money_interest(
     money_portable
    ,
     interest_rate
  )
  returns void

  immutable
  leakproof
  strict
  security invoker
  parallel safe

  as $$
    begin
      raise exception datatype_mismatch;
    end;
  $$
  language plpgsql
;

create  or replace function add_money_interest(
     interest_rate
    ,
     money_portable
  )
  returns void

  immutable
  leakproof
  strict
  security invoker
  parallel safe

  as $$
    begin
      raise exception datatype_mismatch;
    end;
  $$
  language plpgsql
;

create operator +(
   commutator =  +
  ,leftarg    = money_portable
  ,rightarg   = interest_rate
  ,function   = add_money_interest
);

create operator +(
  commutator =  +
  ,leftarg    = interest_rate
  ,rightarg   = money_portable
  ,function   = add_money_interest
);

select
   cast(100.00 as money_portable) + cast(  0.05 as money_portable) as money_plus_money
  ,cast(100.00 as numeric(14, 2)) + cast(  0.05 as numeric( 5, 5)) as money_plus_interest_before
;
select
   cast(100.00 as money_portable) + cast(  0.05 as interest_rate ) as money_plus_interest
;
select
   cast(  0.05 as interest_rate ) + cast(100.00 as money_portable) as interest_plus_money
;
