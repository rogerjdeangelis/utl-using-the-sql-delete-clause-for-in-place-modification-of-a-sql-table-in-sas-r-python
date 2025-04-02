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

