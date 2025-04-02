%let pgm=utl-using-the-sql-delete-clause-for-in-place-modification-of-a-sql-table-in-sas-r-python;

%stop_submission;

Using the sql delete clause for in place modification of a sql table
Dropping row in place


github
https://tinyurl.com/2kzwzntj
https://github.com/rogerjdeangelis/utl-using-the-sql-delete-clause-for-in-place-modification-of-a-sql-table-in-sas-r-python


SOAPBOX ON
Rarely used but versatile delete clause in most sql dialects, better than truncate clause?

The DELETE clause is highly versatile and essential for scenarios requiring
selective row removal while maintaining table integrity and supporting advanced
features like triggers, subqueries, keys and indexes..

NOTE: You can always

   create table my_table (
      team char(10),
      points num,
      rebounds num
   )
   and set inex and sort flags

SAS provides the like clause create table new_table like original_table,
but does not operate on the same table

For other datastep methods  create an empty table
https://github.com/rogerjdeangelis/utl-the-four-types-of-empty-sas-tables
https://github.com/rogerjdeangelis/utl-create-empty-r-dataframes-sql-tables-n-sas-datasets

SOAPBOX OFF

Example maintaining indexes, sort flag . sas table attributes like compression.

       CONTENTS (delete versus create table)

         1 drop male students (same code in r python sql)
         2 drop all all rows (same code in r python sql)

/*
  ___ ___  _ __ ___  _ __   __ _ _ __ ___
 / __/ _ \| `_ ` _ \| `_ \ / _` | `__/ _ \
| (_| (_) | | | | | | |_) | (_| | | |  __/
 \___\___/|_| |_| |_| .__/ \__,_|_|  \___|
                    |_|
*/

/**************************************************************************************************************************/
/*COMPARISON OF "DELETE FROM" VS CREATE TABLE(I REALIZE CREATE TABLE BUILDS A NEW TABLE, BUT WAnTED TO SHOW WHAT CHANGES) */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                     |                                 |                                                                */
/*       INPUT         |   DELETE FROM     CREATE TABLE  |      DELETE FROM                   CREATE TABLE                */
/*       =====         |   ===========     ============  |      ===========                   ============                */
/*                     |                                 |                                                                */
/*                     | 1 DROP MALE STUDENTS            |                                                                */
/*                     | ====================            |                                                                */
/*                     |                                 |                                                                */
/* proc sort           | proc sql;       proc sql;       |  Data Set Name  WORK.CLASS    Data Set Name  WORK.CLASS        */
/*  data=sashelp.class |   delete         create         |  Observations        9  F     Observations          9 F        */
/*  out=class(         |   from class     table class as |  Variables           5        Variables             5          */
/*   compress=binary   |  where          select          |  Indexes              1       Indexes               0          */
/*   index=            |    sex="M"        *             |  Observation Length  33       Observation Length    40         */
/*    (name/unique));  | ;quit            from           |  Deleted Obs         10       Deleted Observations  0          */
/*   by name;          |                   cLass         |  Compressed          BINARY   Compressed            NO         */
/* run;quit;           |                  where          |  Reuse Space         NO                                        */
/*                     |                   sex ne "M"    |  Point to Obs        YES                                       */
/*                     |                 ;quit;          |  Sorted              YES      Sorted                NO         */
/*                     |                                 |                                                                */
/*                     |                                 |  Indexes and Attributes                                        */
/*                     |                                 |          Unique Unique                                         */
/*                     |                                 |  # Index Option Values                                         */
/*                     |                                 |  1 NAME  YES         9                                         */
/*                     |                                 |                                                                */
/*                     |                                 |   Sort Information                                             */
/*                     |                                 |                                                                */
/*                     |                                 |  Sortedby       NAME                                           */
/*                     |                                 |  Validated      YES                                            */
/*                     |                                 |  Character Set  ANSI                                           */
/*                     |                                 |                                                                */
/*                     |--------------------------------------------------------------------------------------------------*/
/*                     |                                 |                                                                */
/*                     |   DELETE FROM     CREATE TABLE  |      DELETE FROM                   CREATE TABLE                */
/*                     |   ===========     ===========   |      ===========                   ============                */
/*                     |                                 |                                                                */
/*                     | 2 DROP ALL ALL ROWS             |                                                                */
/*                     | ===================             |                                                                */
/*                     |                                 |                                Observations          0         */
/*                     | proc sql;       proc sql;       |   Data Set Name  WORK.CLASS    Variables             5         */
/*                     |   delete         create         |  Observations         0        Indexes               0         */
/*                     |   from class     table class as |  Variables            5        Observation Length    40        */
/*                     | :quit;           select         |   Indexes             1        Deleted Observations  0         */
/*                     |                   *             |  Observation Length  33        Compressed            NO        */
/*                     |                  from           |  Deleted Obs         10                                        */
/*                     |                   class         |  Compressed          BINARY                                    */
/*                     |                  where          |  Reuse Space         NO                                        */
/*                     |                   &sqlobs=0     |  Point to Obs        YES                                       */
/*                     |                 ;quit;          |  Sorted              YES       Sorted                NO        */
/*                     |                                 |                                                                */
/*                     |                                 |  Indexes and Attributes                                        */
/*                     |                                 |          Unique Unique                                         */
/*                     |                                 |  # Index Option Values                                         */
/*                     |                                 |  1 NAME  YES         9                                         */
/*                     |                                 |                                                                */
/*                     |                                 |   Sort Information                                             */
/*                     |                                 |                                                                */
/*                     |                                 |  Sortedby       NAME                                           */
/*                     |                                 |  Validated      YES                                            */
/*                     |                                 |  Character Set  ANSI                                           */
/*                     |                                 |                                                                */
/*                     |                                 |                                                                */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/






















































|

COMPARISON OF DELETE FROM TABLE VS CREATE TABLE (REALIZE CREATE TABLE CREATES A NEW TABLE, BUT WNATED TO SHOW WHAT CHAGES)

      INPUT           DELETE                 CREATE              DELETE                             CREATE TABLE
      =====

proc sort           proc sql;              proc sql;         Data Set Name  WORK.CLASS         Data Set Name  WORK.CLASS
 data=sashelp.class   delete                create           Observations        9  F          Observations          9 F
 out=class(           from class            table class as   Variables           5             Variables             5
  compress=binary    where                 select            Indexes              1            Indexes               0
  index=               sex="M"               *               Observation Length  33            Observation Length    40
   (name/unique));  ;quit                   from             Deleted Obs         10            Deleted Observations  0
  by name;                                   cLass           Compressed          BINARY        Compressed            NO
run;quit;                                   where            Reuse Space         NO
                                             sex ne "M"      Point to Obs        YES
                                           ;quit;            Sorted              YES           Sorted                NO

                                                             Indexes and Attributes
                                                                     Unique Unique
                                                             # Index Option Values
                                                             1 NAME  YES         9

                                                              Sort Information

                                                             Sortedby       NAME
                                                             Validated      YES
                                                             Character Set  ANSI

                                                                                               Observations          0
                    proc sql;              proc sql;          Data Set Name  WORK.CLASS        Variables             5
                      delete                create           Observations        0             Indexes               0
                      from class            table class as   Variables           5             Observation Length    40
                   ;quit;                  select            Indexes             1             Deleted Observations  0
                                             *               Observation Length  33            Compressed            NO
                                            from             Deleted Obs         10
                                             class           Compressed          BINARY
                                            where            Reuse Space         NO
                                             &sqlobs=0       Point to Obs        YES
                                           ;quit;            Sorted              YES           Sorted                NO

                                                             Indexes and Attributes
                                                                     Unique Unique
                                                             # Index Option Values
                                                             1 NAME  YES         9

                                                              Sort Information

                                                             Sortedby       NAME
                                                             Validated      YES
                                                             Character Set  ANSI






















  CREATE              DELETE

                                         Data Set Name          WORK.CLASS
proc sql;              proc sql;
  delete                create           Observations           9
  from class            table class as  Variables              5
 where                 select           Indexes                1
   sex="M"               *               Observation Length     33
;quit                   from             Deleted Observations   10
                         cLass           Compressed             BINARY
                        where            Reuse Space            NO
                         sex="M"         Point to Observations  YES
                       ;quit;            Sorted                 YES

                                         Alphabetic List of Indexes and Attributes

                                                                   # of
                                                       Unique    Unique
                                         #    Index    Option    Values


                                         1    NAME     YES            9

                                          Sort Information

                                         Sortedby       NAME
                                         Validated      YES
                                         Character Set  ANSI                                Data Set Name          WORK.CLASS
    Observations           19
    Variables              5
    Indexes                1
    Observation Length     33
    Deleted Observations   0
    Compressed             BINARY
    Reuse Space            NO
    Point to Observations  YES


    Indexes and Attributes
                              # of
                  Unique    Unique
    #    Index    Option    Values
    1    NAME     YES           19

     Sort Information

    Sortedby       NAME
    Validated      YES
    Character Set  ANSI

                                                                                                         DELETE
    NAME    SEX AGE HEIGHT WEIGHT
                                                                                                     Data Set Name          WORK.CLASS
    Alfred   M   14  69.0   112.5
    Alice    F   13  56.5    84.0                                                                    Observations           9
    Barbara  F   13  65.3    98.0                                                                    Variables              5
    Carol    F   14  62.8   102.5                                                                    Indexes                1
    Henry    M   14  63.5   102.5                                                                    Observation Length     33
    James    M   12  57.3    83.0                                                                    Deleted Observations   10
    Jane     F   12  59.8    84.5                                                                    Compressed             BINARY
    Janet    F   15  62.5   112.5                                                                    Reuse Space            NO
    Jeffrey  M   13  62.5    84.0                                                                    Point to Observations  YES
    John     M   12  59.0    99.5                                                                    Sorted                 YES
    Joyce    F   11  51.3    50.5
    Judy     F   14  64.3    90.0                                                                    Alphabetic List of Indexes and Attributes
    Louise   F   12  56.3    77.0
    Mary     F   15  66.5   112.0                                                                                              # of
    Philip   M   16  72.0   150.0                                                                                  Unique    Unique
    Robert   M   12  64.8   128.0                                                                    #    Index    Option    Values
    Ronald   M   15  67.0   133.0
    Thomas   M   11  57.5    85.0
    William  M   15  66.5   112.0                                                                    1    NAME     YES            9

                                                                                                      Sort Information

                                                                                                     Sortedby       NAME
                                                                                                     Validated      YES
                                                                                                     Character Set  ANSI







           sashelp.class










proc sql;              proc sql;
  delete from class     create table class
  where sex='M'         from class
;quit;                  where sex="M"
                        ;quit;

















SOAPBOX OFF

 CONTENTS
                                                                   Data Set Name          WORK.CLASS

                                                                   Observations           9
         INPUT                                                     Variables              5
                                                                   Indexes                1
proc sort data=sashelp.class                                       Observation Length     33
 out=class(                                                        Deleted Observations   10
   compress=binary                                                 Compressed             BINARY
   index=(name/unique));                                           Reuse Space            NO
  by name;                                                         Point to Observations  YES
run;quit;                                                          Sorted                 YES

proc sql;                                                          Alphabetic List of Indexes and Attributes
  delete from class
  where sex='M'                                                                              # of
;quit;                                                                           Unique    Unique
                                                                   #    Index    Option    Values
proc sql;
  create
                                                                   1    NAME     YES            9

                                                                    Sort Information

                                                                   Sortedby       NAME
                                                                   Validated      YES
                                                                   Character Set  ANSI



























I did not know the sql delete clause existed.
I could not get the except or not exist to work?

Delete row table if the column values exist in another table example of rare sql delete clause

https://communities.sas.com/t5/SAS-Programming/Flagging-events-occurring-outside-a-14-day-window/m-p/840618#M332375

https://communities.sas.com/t5/user/viewprofilepage/user-id/462

LOGIC

   SD1.SURVEY1        SD1.SURVEY2


  NOTE EACH COLUMN    SURVEY2           REMOVE PARTIAL QUESTIONIARES IN SURVEY2                       OUTPUT
  IS A PRIMARY KEY    PARTIAL
  QUE3 IS COUNT       RESPONSES

  QUE1 QUE2 QUE3      QUE1 QUE2 QUE3    QUE1 QUE2 QUE3 (INDIVIDUAL CELLS ARE PRIMARY KEYS)

   u1   1    11             1    11      u1   1    11  remove because survey2 has 1 & 11
   u2   2    22                  22      u2   2    22  remove because survey2 has 22
   u2   2    33        u3                u2   2    33
   u3   3    44                          u3   3    44  remove because survey2 has u3
   u4   4    55                          u4   4    55
   u5   5    66                          u5   5    66


           INPUT                      PROCESS                                               OUTPUT
           =====                      =======                                               =======

        SURVEY1
        QUE1 QUE2 QUE3

         u1   1    11             You cannot rerun without reloading
         u2   2    22             the input datasets
         u2   2    33
         u3   3    44
         u4   4    55             proc sql;                                             QUE1    QUE2    QUE3
         u5   5    66             delete
                                   from sd1.survey1 as s1                                u2      2       33
                                  where exists (                                         u4      4       55
        SURVEY2                    select * from sd1.survey2 as s2                       u5      5       66
        QUE1 QUE2 QUE3             where
                                    (
              1    11                  (s2.que1= s1.que1)
                   22                + (s2.que2= s1.que2)
         u3                          + (s2.que3= s1.que3) ) =
                                     (3 - cmiss(s2.que1,s2.que2,s2.que3 ))
       options                      );
        validvarname=upcase;      create
       libname sd1 "d:/sd1";          table want as
       * WORKS;                   select
       data sd1.survey1;              que1
       input (que1-que3) ($);        ,que2
       cards4;                       ,que3
       u1 1 11                    from
       u2 2 22                       sd1.survey1
       u2 2 33                    ;quit;
       u3 3 44
       u4 4 55
       u5 5 66
       ;;;;
       run;quit;

       data sd1.survey2;
       input (que1-que3) ($);
       cards4;
       .    1 11
       .  .   22
       u3 .   .
       ;;;;
       run;quit;







options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
survey1<-read_sas("d:/sd1/survey1.sas7bdat")
survey2<-read_sas("d:/sd1/survey2.sas7bdat")
want <-sqldf('
  delete
   from survey1 as s1
  where exists (
   select * from survey2 as s2
   where
    (
       (s2.que1= s1.que1)
     + (s2.que2= s1.que2)
     + (s2.que3= s1.que3) ) =
     (3 - ((s2.que1 is null)
         + (s2.que2 is null)
         + (s2.que3 is null)))
    );
  create
      table want as
  select
      que1
     ,que2
     ,que3
  from
     survey1
  ');
print(want)
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;


options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
survey1<-read_sas("d:/sd1/survey1.sas7bdat")
survey2<-read_sas("d:/sd1/survey2.sas7bdat")
survey2[survey2 == ""] <- NA
want <-sqldf('
  delete
   from survey1 as s1
  where exists (
   select * from survey2 as s2
   where
    (
       (s2.que1= s1.que1)
     + (s2.que2= s1.que2)
     + (s2.que3= s1.que3) ) =
     (3 - ((s2.que1 is null)
         + (s2.que2 is null)
         + (s2.que3 is null)))
    );
  create
      table want as
  select
      que1
     ,que2
     ,que3
  from
     survey1
  ');
print(want)
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;


%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
survey1<-read_sas("d:/sd1/survey1.sas7bdat")
survey2<-read_sas("d:/sd1/survey2.sas7bdat")
survey1
survey2[survey2 == ""] <- NA
survey2
want <-sqldf('
  select
    *
   ,((s2.que1= s1.que1)
     + (s2.que2= s1.que2)
     + (s2.que3= s1.que3) )  as matches

   ,(3 - ((s2.que1 is null)
         + (s2.que2 is null)
         + (s2.que3 is null)))
  from
     survey1 as s1 left join survey2 as s2
  on
    ( s1.que1 = s2.que1) or
    ( s1.que2 = s2.que2) or
    ( s1.que3 = s2.que3)
  ');
print(want)
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;







In summary, the DELETE clause is highly versatile and essential for scenarios requiring selective row removal while maintaining table integrity and supporting advanced features like triggers and subqueries.








  The SQL `DELETE` clause offers several advantages over other clauses for specific use cases in
  database management. Here are the key benefits:

 ### **Advantages of the `DELETE` Clause**

  1. **Targeted Row Deletion**
 The `DELETE` clause allows precise removal of rows by specifying
  conditions in the `WHERE` clause. This targeted approach is ideal for situations where only
  specific records need to be removed, unlike `TRUNCATE`, which deletes all rows without
  filtering[2][8].

 2. **Preservation of Table Structure**
 When using `DELETE`, the table
  structure, indexes, and constraints remain intact. This makes it suitable for applications where
  the table will continue to be used after removing certain records[4][8].

 3. **Flexibility
  with Subqueries**
 The `DELETE` clause supports subqueries and joins, enabling complex deletion
  operations based on data from other tables. For example, rows can be deleted using conditions
  derived from a subquery or a `USING` clause[5][7].

 4. **Transaction Logging**
 Unlike
  `TRUNCATE`, which uses minimal logging, `DELETE` provides full transaction logging. This ensures
  that changes can be rolled back in case of errors, making it safer for critical operations[1][6].


 5. **Trigger Compatibility**
 The `DELETE` clause activates any associated triggers defined
  on the table, allowing additional operations (e.g., logging or cascading deletions) to occur
  automatically when rows are removed[4].

 6. **Output Clause for Auditing**
 In SQL Server,
  the `OUTPUT` clause can be used with `DELETE` to return information about deleted rows. This is
  useful for auditing or tracking changes during data manipulation[9].

 7. **Customizable
  Identity Handling**
 While `TRUNCATE` resets identity columns automatically, `DELETE` allows
  developers to control whether identity values are reset or preserved, providing greater flexibility
  in managing table data[1][4].

 ### **Comparison with Other Clauses**
 | Feature
   | DELETE                     | TRUNCATE                  | DROP TABLE                 |

  |-----------------------|----------------------------|---------------------------|------------------
  ----------|
 | Row-specific deletion | Yes (via WHERE clause)     | No (removes all rows)     |
  No (removes entire table)  |
 | Preserves table schema| Yes                        | Yes
               | No                         |
 | Transaction logging   | Full logging
  | Minimal logging           | Not applicable             |
 | Trigger activation    | Yes
                 | No                        | No                         |
 | Subquery support
   | Yes                        | No                        | No                         |

 In
  summary, the `DELETE` clause is highly versatile and essential for scenarios requiring selective
  row removal while maintaining table integrity and supporting advanced features like triggers and
  subqueries.

 Citations:
 [1]
  https://blog.quest.com/the-best-ways-to-use-sql-delete-statement-in-a-sql-table/
 [2]
  https://www.dbvis.com/thetable/the-sql-delete-statement-explained/
 [3]
  https://www.sqlservercentral.com/forums/topic/delete-with-in-case-statement
 [4]
  https://www.ibm.com/docs/en/db2-for-zos/12?topic=programs-deleting-data-from-tables
 [5]
  https://www.postgresql.org/docs/current/sql-delete.html
 [6]
  https://asktom.oracle.com/ords/f?p=100%3A11%3A0%3A%3A%3A%3AP11_QUESTION_ID%3A5033906925164
 [7]
  https://www.universalclass.com/articles/computers/sql/using-the-delete-statement-in-sql.htm
 [8]
  https://www.w3schools.com/sql/sql_delete.asp
 [9]
  https://www.red-gate.com/simple-talk/databases/sql-server/learn/the-delete-statement-in-sql-server/

 [10] https://stackoverflow.com/questions/1177810/sql-server-delete-and-with-clause
 [11]
  https://learn.microsoft.com/en-us/sql/t-sql/statements/delete-transact-sql?view=sql-server-ver16


 ---
 Answer from Perplexity: pplx.ai/share
























proc sql;
delete
 from survey1 as s1
where exists (
 select * from survey2 as s2
 where
  (
     (s2.que1= s1.que1)
   + (s2.que2= s1.que2)
   + (s2.que3= s1.que3) ) =
   (3 - cmiss(s2.que1,s2.que2,s2.que3 ))
  );
create
    table want as
select
    que1
   ,que2
   ,que3
from
   survey1
;quit;


* WORKS NOTE ALL EACH COLUMN IS A UNIQUE KEY;
data survey1;
input (que1-que3) ($);
cards4;
u1 1 11  remove because survey2 has 1 & 11
u2 2 22  remove because survey2 has 22
u2 2 33
u3 3 44  remove because survey2 has u3
u4 4 55
u5 5 66
;;;;
run;quit;


data survey2;
input (que1-que3) ($);
datalines;
.    1 11
.  .   22
u3 .   .
;
run;quit;





























proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
      (
         (que1= a.que1)
       + (que2= a.que2)
       + (que3= a.que3) ) =
       (3 - cmiss(que1,que2,que3 ))
      );
create
   table want as
select
   *
from
A;
;quit;


options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
  input ID $ dte $10.;
cards4;
A 2022-07-01
A 2022-07-14
A 2022-07-15
A 2022-07-30
A 2022-07-31
A 2022-08-15
B 2022-01-01
B 2022-01-14
B 2022-01-15
B 2022-01-30
B 2022-01-31
B 2022-02-15
;;;;
run;quit;


proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
SELECT
  id,
  dte,
  CASE
    WHEN julianday(dte) < (julianday(group_start) + 14)
      AND julianday(dte) >= julianday(group_start) THEN 1
    ELSE 0
  END AS outside_two_weeks
FROM (
  SELECT
    id,
    dte,
    MIN(dte) OVER (PARTITION BY id) AS group_start
  FROM have
)  sub;
')
want
;;;;
%utl_rendx;


data have;
input ID event_date : DATE9. ;
format event_date DATE9.;
cards;
18901 01JUL2022
18901 14JUL2022
18901 15JUL2022
18901 30JUL2022
18901 31JUL2022
18901 15AUG2022
18902 01JUL2022
18902 14JUL2022
18902 15JUL2022
18902 30JUL2022
18902 31JUL2022
18902 15AUG2022
;

data want(drop = c);
   set have;
   by ID;

   c + dif(event_date);

   if first.ID | c ge 14 then do;
      flag = 1;
      c = 0;
   end;

run;


data A;
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100
u2 2 example2@gmail.com  v2 120
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B;
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
   |    |
;


proc sql;
create
  table x as
  select * from A;
  select * from B;
  delete from A
  where exists (
      select * from B
      where
          cmiss(User_Id, Customer_Id, Email_Add) < 3 and
          ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
          (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
  select * from A;
  quit;




data A;
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100
u2 2 example2@gmail.com  v2 120
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B;
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
   |    |
;
run;quit;

proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
        cmiss(User_Id, Customer_Id, Email_Add) < 3 and
            ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
             (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A;
quit;

                                                             INVOICE_
USER_ID   CUSTOMER_ID  EMAIL_ADD             INVOICE_NO       ACCOUNT
---------------------------------------------------------------------
u2                  2  example2b@gmail.com   v3                   130
u4                  4  example4@gmail.com    v5                   165
u5                  5  example5@gmail.com    v6                   180




data A;
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100  remove
u2 2 example2@gmail.com  v2 120  remove
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150  remove
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B;
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
   |    |
;
run;quit;

proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
        cmiss(User_Id, Customer_Id, Email_Add) < 3 and
            ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
             (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A;
quit;

                                                             INVOICE_
USER_ID   CUSTOMER_ID  EMAIL_ADD             INVOICE_NO       ACCOUNT
---------------------------------------------------------------------
u2                  2  example2b@gmail.com   v3                   130
u4                  4  example4@gmail.com    v5                   165
u5                  5  example5@gmail.com    v6                   180



data sd1.survey;
  set sashelp.class(obs=5 keep=name age sex);
  rename=(name=que1 que2
run;quit;


  NAME      SEX    AGE


Remove records from survey2 that have partial data in survey2

data survey1;
input (que1-que3) ($);
cards4;
Alfred  M  14
Alice   F  13
Barbara F  13
Carol   F  14
Henry   M  14
;;;;
run;quit;

data survey2;
input (que1-que3) ($);
cards4;
 .       M 14
 .       . 13
 Barbara . .
;;;;
run;quit;





proc sql;
  create
     table want as
  select
     l.que1
    ,l.que2
    ,l.que3
    ,( (l.que1 = r.que1)
     + (l.que2 = r.que2)
     + (l.que3 = r.que3) ) as eq
    ,(3 - cmiss(r.que1,r.que2,r.que3 )) as pop
  from
    survey1 as l inner join survey2 as r
  on
    1=1
;quit;
  on
     ( (l.que1 = r.que1)
     + (l.que2 = r.que2)
     + (l.que3 = r.que3) ) =
     (3 - cmiss(r.que1,r.que2,r.que3 ))
;quit;


data A;
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100  remove
u2 2 example2@gmail.com  v2 120  remove
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150  remove
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B;
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
   |    |
;
run;quit;

proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
        cmiss(User_Id, Customer_Id, Email_Add) < 3 and
            ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
             (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A;
quit;



  ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
   (3 - cmiss(User_Id, Customer_Id, Email_Add))   );


proc sql;
delete
   from survey1 as r
where exists (
    select * from survey2 as l
    where
     ( (l.que1 = r.que1)
     + (l.que2 = r.que2)
     + (l.que3 = r.que3) ) =
     (3 - cmiss(r.que1,r.que2,r.que3 )) )
;quit;


data survey1;
input (que1-que3) ($);
cards4;
Alfred  M  14
Alice   F  13
Barbara F  13
Carol   F  14
Henry   M  14
;;;;
run;quit;

data survey2;
input (que1-que3) ($);
cards4;
 .       M 14
 .       . 13
 Barbara . .
;;;;
run;quit;


proc sql;
delete
   from survey1 as l
where exists (
    select * from survey2 as r
    where
     (
        (l.que1 = r.que1)
      + (l.que2 = r.que2)
      + (l.que3 = r.que3) ) =
      (3 - cmiss(r.que1,r.que2,r.que3 ))
     )
;
select
    *
from
    survey1
;quit;

data A(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100  remove
u2 2 example2@gmail.com  v2 120  remove
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150  remove
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
   |    |
;
run;quit;


proc sql;
delete
   from survey1 as l
where exists (
    select * from survey2 as r
    where
     (
        (l.que1 = r.que1)
      + (l.que2 = r.que2)
      + (l.que3 = r.que3) ) =
      (3 - cmiss(r.que1,r.que2,r.que3 ))
     )
;
select
    *
from
    survey1
;quit;


* WORKS;
data A(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20.;
datalines;
u1 1 example1@gmail.com
u2 2 example2@gmail.com
u2 2 example2b@gmail.com
u3 3 example3@gmail.com
u4 4 example4@gmail.com
u5 5 example5@gmail.com
;


data B(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
;
run;quit;


proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
      (
         (que1= a.que1)
       + (que2= a.que2)
       + (que3= a.que3) ) =
       (3 - cmiss(que1,que2,que3 ))
      );
select * from A;
;quit;

QUE1          QUE2  QUE3
----------------------------------------
u2               2  example2b@gmail.com
u4               4  example4@gmail.com
u5               5  example5@gmail.com


* WORKS;
data A(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20.;
datalines;
u1 1 11
u2 2 22
u2 2 33
u3 3 44
u4 4 55
u5 5 66
;


data B(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 | 11
   |    | 22
u3 |    |
;
run;quit;


proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
      (
         (que1= a.que1)
       + (que2= a.que2)
       + (que3= a.que3) ) =
       (3 - cmiss(que1,que2,que3 ))
      );
select * from A;
;quit;

https://communities.sas.com/t5/user/viewprofilepage/user-id/462

* WORKS NOTE ALL EACH COLUMN IS A UNIQUE KEY;
data survey1;
input (que1-que3) ($);
datalines;
u1 1 11  remove because survey2 has 1 & 11
u2 2 22  remove because survey2 has 22
u2 2 33
u3 3 44  remove because survey2 has u3
u4 4 55
u5 5 66
;


data survey2;
input (que1-que3) ($);
datalines;
.    1 11
.  .   22
u3 .   .
;
run;quit;


proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
      (
         (que1= a.que1)
       + (que2= a.que2)
       + (que3= a.que3) ) =
       (3 - cmiss(que1,que2,que3 ))
      );
select * from A;
;quit;


https://communities.sas.com/t5/user/viewprofilepage/user-id/462



options validvarname=upcase;
libname sd1 "d:/sd1";
* WORKS;
data survey1;
input (que1-que3) ($);
cards4;
u1 1 11
u2 2 22
u2 2 33
u3 3 44
u4 4 55
u5 5 66
;;;;
run;quit;

data sd1.have;
input (que1-que3) ($);
cards4;
.    1 11
.  .   22
u3 .   .
;;;;
run;quit;


proc sql;
delete from survey1 as s1
where exists (
    select * from survey2 as s2
    where
      (
         (s2.que1= s1.que1)
       + (s2.que2= s1.que2)
       + (s2.que3= s1.que3) ) =
       (3 - cmiss(s2.que1,s2.que2,s2.que3 ))
      );
create
    table want as
select
    que1
   ,que2
   ,que3
from
   survey1
;quit;































data A(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100  remove
u2 2 example2@gmail.com  v2 120  remove
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150  remove
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B(rename=(User_ID=que1  Customer_ID=que2 Email_add=que3));
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
;
run;quit;


proc sql;
select * from A;
select * from B;
delete from A
where exists (
    select * from B
    where
      (
         (que1= a.que1)
       + (que2= a.que2)
       + (que3= a.que3) ) =
       (3 - cmiss(que1,que2,que3 ))
      );
select * from A;
;quit;













            ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
             (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A;
quit;






























        cmiss(User_Id, Customer_Id, Email_Add) < 3 and
            ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
             (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A;
quit;


















 .           M      14
 Alice       F      13
 .           .      13
 Carol       F      14
 Henry       M      14
















fn_tosas9x(
      inp    = have
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

























SELECT
  group_id,
  event_id,
  event_date,
  CASE
    WHEN ABS(julianday(event_date) - julianday(group_reference_date)) > 14
    THEN 1
    ELSE 0
  END AS outside_two_weeks
FROM (
  SELECT
    t.*,
    MIN(event_date) OVER (PARTITION BY group_id) AS group_reference_date
  FROM your_table t
)



data A;
input User_ID $ Customer_ID Email_add :$20. Invoice_no $ Invoice_account;
datalines;
u1 1 example1@gmail.com  v1 100
u2 2 example2@gmail.com  v2 120
u2 2 example2b@gmail.com v3 130
u3 3 example3@gmail.com  v4 150
u4 4 example4@gmail.com  v5 165
u5 5 example5@gmail.com  v6 180
;


data B;
input User_ID $ Customer_ID Email_add :$20.;
infile datalines missover dlm = '|';
datalines;
   |  1 |example1@gmail.com
   |    |example2@gmail.com
u3 |    |
;


proc sql;
select * from a
except
   (
    select * from B
    where
        ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
        (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A;
quit;


proc sql;
select * from (
delete from A
where exists (
    select * from B
    where
        ((User_Id=A.User_Id) + (Customer_Id=A.Customer_Id) + (Email_Add=A.Email_Add)) =
        (3 - cmiss(User_Id, Customer_Id, Email_Add))   );
select * from A);
quit;

















Up to 40 obs from WANT total obs=12 01APR2025:13:53:24

A                                                             INVOICE_
USER_ID   CUSTOMER_ID  EMAIL_ADD             INVOICE_NO       ACCOUNT
---------------------------------------------------------------------
u1                  1  example1@gmail.com    v1                   100
u2                  2  example2@gmail.com    v2                   120
u2                  2  example2b@gmail.com   v3                   130
u3                  3  example3@gmail.com    v4                   150
u4                  4  example4@gmail.com    v5                   165
u5                  5  example5@gmail.com    v6                   180


B
Up to 40 obs from WANT total obs=12 01APR2025:13:53:24

USER_ID   CUSTOMER_ID  EMAIL_ADD
-------------------------------------------
                    1  example1@gmail.com
                    .  example2@gmail.com
u3                  .
                    .


Up to 40 obs from WANT total obs=12 01APR2025:13:53:24

                                                             INVOICE_
USER_ID   CUSTOMER_ID  EMAIL_ADD             INVOICE_NO       ACCOUNT
---------------------------------------------------------------------
u2                  2  example2b@gmail.com   v3                   130
u4                  4  example4@gmail.com    v5                   165
u5                  5  example5@gmail.com    v6                   180
