--Karla Gabriela Navarro Raudales  20191003134   Seccion: 0800 L-J

--Bloques anonimos
-- Inciso a

SET SERVEROUTPUT ON
DECLARE
   CURSOR C1_EMPLEADOS IS SELECT*FROM  EMPLOYEES;
   v1 EMPLOYEES%ROWTYPE;
BEGIN
 FOR v1 IN C1_EMPLEADOS LOOP
   IF v1.FIRST_NAME='Peter' AND v1.LAST_NAME='Tucker' THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede ver el sueldo del jefe');
   ELSE
    dbms_output.put_line(v1.FIRST_NAME ||' '||V1.LAST_NAME ||'  '||V1.SALARY);
   END IF;
 END LOOP;
END;


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inciso b

SET SERVEROUTPUT ON
DECLARE
   id_departamento DEPARTMENTS.DEPARTMENT_ID%TYPE;
   CURSOR C2_DEPARTAMENTOS(id_departamento NUMBER) IS SELECT COUNT(*) FROM DEPARTMENTS WHERE DEPARTMENT_ID=id_departamento;
   numero_empleados number;
BEGIN
   id_departamento:=30;
   OPEN C2_DEPARTAMENTOS(id_departamento);
   FETCH C2_DEPARTAMENTOS INTO numero_empleados;
   dbms_output.put_line('El Departamento: '||id_departamento||' tiene '||numero_empleados||' empleados');
   CLOSE C2_DEPARTAMENTOS;
END;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inciso c

SET SERVEROUTPUT ON
DECLARE
   CURSOR C3_EMPLEADOS IS SELECT*FROM EMPLOYEES;
   v3 EMPLOYEES%ROWTYPE;
   total_salario NUMBER;
BEGIN
   FOR v3 IN C3_EMPLEADOS LOOP
     IF v3.SALARY >'8000' THEN
       total_salario:=(v3.SALARY*0.02)+v3.SALARY;
       dbms_output.put_line(v3.FIRST_NAME ||' '||v3.LAST_NAME ||'  '||total_salariO);
     ELSE
        total_salario:=(v3.SALARY*0.03)+v3.SALARY;
        dbms_output.put_line(v3.FIRST_NAME ||' '||v3.LAST_NAME ||'  '||total_salario);
    END IF;
  END LOOP; 
END;
  
  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------  
--Funciones
--Inciso a

CREATE OR REPLACE FUNCTION CREAR_REGION (nombre IN VARCHAR2)
RETURN NUMBER
IS
cod_region NUMBER;
nombre_region varchar2(60);
BEGIN
   SELECT REGION_NAME INTO nombre_region FROM REGIONS WHERE REGION_NAME=nombre;
   RAISE_APPLICATION_ERROR(-20003, '¡Esta Region ya existe!');
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
   SELECT MAX(REGION_ID)+1 INTO cod_region FROM REGIONS;
     INSERT INTO REGIONS VALUES (cod_region, nombre);
   RETURN cod_region;
END;

SET SERVEROUTPUT ON
DECLARE
  A VARCHAR2(60);
  R NUMBER;
BEGIN
  A:='Portugal';
  R:=CREAR_REGION(A);
 DBMS_OUTPUT.PUT_LINE('Su codigo de region es: '||R);
END;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--Procedimientos
--Inciso a

CREATE OR REPLACE PROCEDURE CALCULADORA (operacion IN VARCHAR2, num1 IN NUMBER, num2 IN NUMBER, resultado out NUMBER)
IS
BEGIN 
 IF operacion='SUMA' THEN
      resultado:=num1+num2;
      
  ELSIF operacion='RESTA' THEN
     resultado:=num1-num2;
     
  ELSIF operacion='MULTIPLICACION' THEN
     resultado:=num1*num2;

  ELSIF operacion='DIVISION' THEN
       resultado:=num1/num2;
  ELSE 
   RAISE_APPLICATION_ERROR(-20001, 'No se puede realizar');
 END IF;
END;


SET SERVEROUTPUT ON
DECLARE
  A VARCHAR2(60);
  B NUMBER;
  C NUMBER;
  R NUMBER;
BEGIN
  A:='SUMA';
  B:=40;
  C:=10;
  R:=0;
  CALCULADORA(A,B,C,R);
 DBMS_OUTPUT.PUT_LINE('El resultado de la '||A||' es : '||R);
END;


------------------------------------------------------------------------------------------------------------------------------------------------------------
--Inciso b

CREATE TABLE
EMPLOYEES_COPIA
                 (EMPLOYEE_ID NUMBER (6,0) PRIMARY KEY,
                    FIRST_NAME VARCHAR2(20 BYTE),
                    LAST_NAME VARCHAR2(25 BYTE),
                    EMAIL VARCHAR2(25 BYTE),
                    PHONE_NUMBER VARCHAR2(20 BYTE),
                    HIRE_DATE DATE,
                    JOB_ID VARCHAR2(10 BYTE),
                    SALARY NUMBER(8,2),
                    COMMISSION_PCT NUMBER(2,2),
                    MANAGER_ID NUMBER(6,0),
                    DEPARTMENT_ID NUMBER(4,0)
                  );

CREATE OR REPLACE PROCEDURE COPIA_EMPL (mensaje out VARCHAR2) IS 
 id_empleado employees_copia.employee_id%TYPE;
 nombre_empleado employees_copia.first_name%TYPE; 
 apellido employees_copia.last_name%TYPE;
 correo employees_copia.email%TYPE;
 tel  employees_copia.phone_number%TYPE;
 fechaC  employees_copia.hire_date%TYPE;
 job_id  employees_copia.job_id%TYPE;
 salario  employees_copia.salary%TYPE;
 comi  employees_copia.commission_pct%TYPE;
 manager_id  employees_copia.manager_id%TYPE;
 depto_id  employees_copia.department_id%TYPE;
 control number;
BEGIN
 id_empleado:= 4;
 nombre_empleado:= 'Karla'; 
 apellido:= 'Gutierrez';
 correo:= 'kgnr_30';
 tel:= '98887777';
 fechaC:= SYSDATE;
 job_id:= 'ID_JOB';
 salario:= 25000;
 comi:= 0.10;
 manager_id:= 11;
 depto_id:= 11;
   control := 0;
	SELECT COUNT(*) INTO control FROM employees_copia WHERE  employee_id = id_empleado;
	IF control = 0 then 
        INSERT INTO  employees_copia VALUES (id_empleado,nombre_empleado,apellido,correo,tel,fechaC,job_id,salario,comi,manager_id,depto_id);  
        mensaje := 'Carga Finalizada'; 
    ELSE
        mensaje := '¡Registro ya Existe!'; 
	END IF;
END;



SET SERVEROUTPUT ON
DECLARE
  A VARCHAR2(100);
BEGIN
  COPIA_EMPL(A);
  DBMS_OUTPUT.PUT_LINE(A);
END;


---------------------------------------------------------------------------------------------------------------------------------------------------

--Triggers

--Inciso a

CREATE OR REPLACE TRIGGER TR1_DEPARTAMENTO
BEFORE INSERT ON DEPARTMENTS
FOR EACH ROW
BEGIN
  SELECT DEPARTMENT_ID INTO :NEW.DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = :NEW.DEPARTMENT_ID;
  RAISE_APPLICATION_ERROR(-20004, 'Este Departamento ya existe');
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
     IF (:NEW.LOCATION_ID IS NULL) THEN
      :NEW.LOCATION_ID:=1700;
      END IF;
     IF (:NEW.MANAGER_ID IS NULL) THEN
      :NEW.MANAGER_ID:=200;
     END IF;
END;

INSERT INTO DEPARTMENTS VALUES (308, 'Publicidad', NULL, NULL);


--------------------------------------------------------------------------------------------------------------------------------------------------------
--Inciso b

CREATE TABLE 
AUDITORIA 
          (USUARIO VARCHAR(50),
             FECHA DATE,
             SALARIO_ANTIGUO NUMBER,
             SALARIO_NUEVO NUMBER
           );
        

CREATE OR REPLACE TRIGGER TR2_AUDITORIA
BEFORE INSERT ON REGIONS
BEGIN
INSERT INTO AUDITORIA VALUES (USER, SYSDATE, 0, 0);
END;

INSERT INTO REGIONS VALUES (35, 'Guatemala');
      

---------------------------------------------------------------------------------------------------------------------------------------------
--Inciso c

CREATE OR REPLACE TRIGGER TR3_EMPLEADOS
BEFORE UPDATE OF SALARY ON EMPLOYEES
FOR EACH ROW
BEGIN
IF (:NEW.SALARY < :OLD.SALARY) THEN
   RAISE_APPLICATION_ERROR(-20000, 'No se puede modificar el salario con un valor menor');
ELSE
INSERT INTO AUDITORIA VALUES (:OLD.EMPLOYEE_ID, SYSDATE, :NEW.SALARY, :OLD.SALARY);
END IF;
END;


UPDATE EMPLOYEES SET SALARY=15000 WHERE EMPLOYEE_ID=199;


