/***********************
-Author: Michal Cierlica
-Script purpose: killing oracle database sessions by particular SQL_ID (any field on v$session can be used)
-Prerequisities: 
                grant select on sys.v$session to user;
                grant alter system to user;

-Feel free to give me any suggestions, remarks or comments at cwirus88@gmail.com
**********************/


SET SERVEROUTPUT ON

BEGIN
    FOR s_kill IN (
        SELECT
            sid,
            serial#
        FROM
            v$session
        WHERE
            sql_id = 'your_sql_id'
    ) LOOP
        EXECUTE IMMEDIATE 'alter system kill session '''
                          || s_kill.sid
                          || ','
                          || s_kill.serial#
                          || '''';

        dbms_output.put_line('The following sessions have been marked to kill: '
                               || s_kill.sid
                               || ' i serialu '
                               || s_kill.serial#
                               || 'It may take a while, please be patient');

    END LOOP;
END;