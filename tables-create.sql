    /* table to hold user data */
CREATE TABLE persons( PERSON_ID	     NUMBER not null , 
                      LASTNAME	VARCHAR2(255) not null, 
					  FIRSTNAME	VARCHAR2(255),
					  AGE	    NUMBER
	                  CONSTRAINT persons_pk PRIMARY KEY (PERSON_ID));
	
	
	/* table to hold DML statements duration logs applied in psersons table */
CREATE TABLE time_dml_log( dml_reference  VARCHAR2(30) , 
						   dml_type   VARCHAR2(6) ,           /* possible values are 'UPDATE', 'INSERT' */
						   dml_date  TIMESTAMP(6) ,           /* DML date */
						   dml_duration  VARCHAR2(10) ,      /* DML duration in µs */
						   CONSTRAINT time_dml_log_pk PRIMARY KEY (dml_reference));