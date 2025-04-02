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
         3 advantages of sql

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
/*  data=sashelp.class |   delete         create         |  Observations        9 Female Observations          9 Female   */
/*  out=class(         |   from class     table class as |  Variables           5        Variables             5          */
/*   compress=binary   |  where          select          |  Indexes             1        Indexes               0          */
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
/*                     |                                 |                                                                */
/*                     | proc sql;       proc sql;       |  Data Set Name  WORK.CLASS     Data Set Name  WORK.CLASS       */
/*                     |   delete         create         |  Observations         0        Observations          0         */
/*                     |   from class     table class as |  Variables            5        Variables             5         */
/*                     | :quit;           select         |   Indexes             1        Indexes               0         */
/*                     |                   *             |  Observation Length  33        Observation Length    40        */
/*                     |                  from           |  Deleted Obs         10        Deleted Observations  0         */
/*                     |                   class         |  Compressed          BINARY    Compressed            NO        */
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

/*____             _                  _                                 __            _
|___ /    __ _  __| |_   ____ _ _ __ | |_ __ _  __ _  ___  ___    ___  / _| ___  __ _| |
  |_ \   / _` |/ _` \ \ / / _` | `_ \| __/ _` |/ _` |/ _ \/ __|  / _ \| |_ / __|/ _` | |
 ___) | | (_| | (_| |\ V / (_| | | | | || (_| | (_| |  __/\__ \ | (_) |  _|\__ \ (_| | |
|____/   \__,_|\__,_| \_/ \__,_|_| |_|\__\__,_|\__, |\___||___/  \___/|_|  |___/\__, |_|
                                               |___/                               |_|
*/

The SQL `DELETE` clause offers several advantages over other clauses for specific use cases in
database management. Here are the key benefits:

 ### **Advantages of the `DELETE` Clause**

  1. **Targeted Row Deletion**
     The `DELETE` clause allows precise removal of rows by specifying
     conditions in the `WHERE` clause. This targeted approach is ideal for situations where only
     specific records need to be removed, unlike `TRUNCATE`, which deletes all rows without
     filtering[2][8].

 2. **Preservation of Table Structure**
    Then using `DELETE`, the table
    structure, indexes, and constraints remain intact. This makes it suitable for applications where
    the table will continue to be used after removing certain records[4][8].

 3. **Flexibility
    with Subqueries**
    The `DELETE` clause supports subqueries and joins, enabling complex deletion
    operations based on data from other tables. For example, rows can be deleted using conditions
    derived from a subquery or a `USING` clause[5][7].

 4. **Transaction Logging**
   Unlike `TRUNCATE`, which uses minimal logging, `DELETE` provides full transaction logging. This ensures
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


 Citations:

 [1] https://blog.quest.com/the-best-ways-to-use-sql-delete-statement-in-a-sql-table/
 [2] https://www.dbvis.com/thetable/the-sql-delete-statement-explained/
 [3] https://www.sqlservercentral.com/forums/topic/delete-with-in-case-statement
 [4] https://www.ibm.com/docs/en/db2-for-zos/12?topic=programs-deleting-data-from-tables
 [5] https://www.postgresql.org/docs/current/sql-delete.html
 [6] https://asktom.oracle.com/ords/f?p=100%3A11%3A0%3A%3A%3A%3AP11_QUESTION_ID%3A5033906925164
 [7] https://www.universalclass.com/articles/computers/sql/using-the-delete-statement-in-sql.htm
 [8] https://www.w3schools.com/sql/sql_delete.asp
 [9] https://www.red-gate.com/simple-talk/databases/sql-server/learn/the-delete-statement-in-sql-server/
 [10] https://stackoverflow.com/questions/1177810/sql-server-delete-and-with-clause
 [11] https://learn.microsoft.com/en-us/sql/t-sql/statements/delete-transact-sql?view=sql-server-ver16
 ---
 Answer from Perplexity: pplx.ai/share

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

