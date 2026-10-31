-- If you like Python data type hints, you might like SQL domains
-- github.com/sqlxpert/data-types-sql-domain-postgresql-operator
-- GPLv3, Copyright Paul Marcelin



-- create database
-- postgresql 18



\connect postgres

drop database if exists dom_op_eg;
create database dom_op_eg
  template        'template0'
  encoding        'UTF8'
  locale_provider 'builtin'
  builtin_locale  'PG_UNICODE_FAST'
;
\connect dom_op_eg

create schema if not exists dom_op_eg;
set search_path to dom_op_eg;
