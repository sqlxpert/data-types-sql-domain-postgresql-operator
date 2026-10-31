# If you like Python data type hints, you might like SQL domains

Source code to accompany my October&nbsp;30,&nbsp;2026 article
(
[LinkedIn](https://www.linkedin.com/pulse/you-like-python-data-type-hints-might-sql-domains-paul-marcelin-te49c) |
[blog](https://sqlxpert.github.io/2026/10/30/data-types-sql-domain-postgresql-operator.html)
)
about stricter types in databases (SQL `domain` and PostgreSQL operators)

## SQL formatting

<details>
  <summary>SQL formatting conventions</summary>
### Current or potential comma-separated lists

- Examples: `select`&nbsp;: `from`&nbsp;, `group by`&nbsp;, `order by`
- 1&nbsp;item per line; indent 1&nbsp;extra space for comma
- Conspicuous **leading comma** prevents syntax errors when items are added

### Boolean expressions

- Examples: `select`&nbsp;: `where`&nbsp;, `having`
- No extra indentation unless and until logical operators (`not`, `or`, `and`)
  are added
- Then, use line breaks, indentation, and parentheses so that the expression
  can be read naturally and parallel parts of the expression can easily be
  recognized

### Operators and keywords

- Always align or space out pairs based on _longer_ item

  ```sql
    =  >    asc   true
   !=  >=  desc  false
  ```

</details>

## Licenses

|Scope|Link|Included Copy|
|:---|:---|:---|
|Source code, and source code in documentation|[GNU General Public License (GPL) 3.0](http://www.gnu.org/licenses/gpl-3.0.html)|[LICENSE-CODE.md](/LICENSE-CODE.md)|
|Documentation, including this ReadMe file|[GNU Free Documentation License (FDL) 1.3](http://www.gnu.org/licenses/fdl-1.3.html)|[LICENSE-DOC.md](/LICENSE-DOC.md)|

Copyright Paul Marcelin

Contact: `marcelin` at `cmu.edu` (replace "at" with `@`)
