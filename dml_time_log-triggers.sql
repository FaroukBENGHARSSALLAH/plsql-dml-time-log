 
      /* this trigger will save the timestamp value before the INSERT DML applied to 'PERSONS' table in the 'moment' global variable */
 CREATE OR REPLACE TRIGGER  TIME_IRT_BFR_TRG BEFORE INSERT ON PERSONS
      BEGIN
             check_time_constant_package.moment := LOCALTIMESTAMP;
      END TIME_IRT_BFR_TRG ;
	 
	 
	  /* this trigger will save the timestamp value before the UPDATE DML applied to 'PERSONS' table in the 'moment' global variable */
 CREATE OR REPLACE TRIGGER  TIME_UDT_BFR_TRG BEFORE UPDATE ON PERSONS
      BEGIN
              check_time_constant_package.moment := LOCALTIMESTAMP;
      END TIME_UDT_BFR_TRG ;
	  
	  
	  
	  
	   /* this trigger will calculate the INSERT DML timestamp duration applied to 'PERSONS' table and insert the log 'time_dml_log table' */
  CREATE OR REPLACE TRIGGER  TIME_IRT_AFT_TRG AFTER INSERT ON PERSONS
      DECLARE 
              moment timestamp;
			  duration VARCHAR2(10);
		         /* Declare local trigger-scope variables. */
			  lv_dml_reference  VARCHAR2(30) := 'INS-' || dbms_random.string('X', 8) || '-DML';
			  lv_dml_type   VARCHAR2(12) := 'INSERT';
      BEGIN
             moment := LOCALTIMESTAMP;
			 duration := (extract(second from moment)-extract(second from check_time_constant_package.moment))*1000000||' µs';
             insert into time_dml_log(dml_reference,    dml_type,    dml_date, dml_duration) values
			                         (lv_dml_reference, lv_dml_type, moment,   duration);
      END TIME_IRT_AFT_TRG ;
	  
	  
	  
	    /* this trigger will calculate the UPDATE DML timestamp duration applied to 'PERSONS' table and insert the log 'time_dml_log table' */
   CREATE OR REPLACE TRIGGER  TIME_UDT_AFT_TRG AFTER UPDATE ON PERSONS
      DECLARE 
              moment timestamp;
			  duration VARCHAR2(10);
		         /* Declare local trigger-scope variables. */
			  lv_dml_reference  VARCHAR2(30) := 'UPD-' || dbms_random.string('X', 8) || '-DML';
			  lv_dml_type   VARCHAR2(12) := 'UPDATE';
      BEGIN
             moment := LOCALTIMESTAMP;
			 duration := (extract(second from moment)-extract(second from check_time_constant_package.moment))*1000000||' µs';
             insert into time_dml_log(dml_reference,    dml_type,    dml_date, dml_duration) values
			                         (lv_dml_reference, lv_dml_type, moment,   duration);
      END TIME_UDT_AFT_TRG ;