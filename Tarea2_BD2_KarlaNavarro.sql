--Karla Gabriela Navarro Raudales  20191003134   Sección: 0800 L-J

--Ejercicio #1

SET SERVEROUTPUT ON;

DECLARE
   nombre varchar2(30);
   apellido1 varchar2(30);
   apellido2 varchar2(30);
   iniciales varchar2(10);
   
BEGIN
   nombre:='alberto';
   apellido1:='perez';
   apellido2:='garcia';
   
   iniciales:=UPPER(SUBSTR(nombre,1,1)||'.'||SUBSTR(apellido1,1,1)||'.'||SUBSTR(apellido2,1,1)||'.');
   dbms_output.put_line(iniciales);
END;


--Ejercicio #2

SET SERVEROUTPUT ON;

DECLARE
   num number;
   
BEGIN
 num:=20;
   If 
      mod (num,2) = 0
  Then
     dbms_output.put_line('Es un número par');
  Else
     dbms_output.put_line('Es un número impar');
  End if;
END;


--Ejercicio #3

SET SERVEROUTPUT ON;

DECLARE
   salario_maximo EMPLOYEES.SALARY%TYPE;
BEGIN
   SELECT MAX(SALARY) INTO salario_maximo FROM EMPLOYEES WHERE DEPARTMENT_ID=100;
    dbms_output.put_line('El salario máximo es: '||salario_maximo);
END;
   
   
--Ejercicio #4


SET SERVEROUTPUT ON;

DECLARE
   id_departamento DEPARTMENTS.DEPARTMENT_ID%TYPE;
   nombre_departamento DEPARTMENTS.DEPARTMENT_NAME%TYPE;
   numero_empleados number;
BEGIN
   id_departamento:=10;
   SELECT DEPARTMENT_NAME INTO nombre_departamento FROM DEPARTMENTS WHERE DEPARTMENT_ID=id_departamento;
   SELECT COUNT(*) INTO numero_empleados FROM EMPLOYEES WHERE DEPARTMENT_ID=id_departamento;
   dbms_output.put_line(nombre_departamento||' tiene '||numero_empleados||' empleados');
END;
   
   
--Ejercicio #5

SET SERVEROUTPUT ON;

DECLARE
   salario_maximo EMPLOYEES.SALARY%TYPE;
   salario_minimo EMPLOYEES.SALARY%TYPE;
   diferencia_salarios number;
BEGIN
   SELECT MAX(SALARY) INTO salario_maximo FROM EMPLOYEES;
    dbms_output.put_line('El salario máximo de la empresa es:'||' '||salario_maximo);
   SELECT MIN(SALARY) INTO salario_minimo FROM EMPLOYEES;
    dbms_output.put_line('El salario minimo de la empresa es:'||' '||salario_minimo);
   diferencia_salarios:=salario_maximo - salario_minimo;
   dbms_output.put_line('La diferencia de los salarios es:'||' '||diferencia_salarios);
END;
   