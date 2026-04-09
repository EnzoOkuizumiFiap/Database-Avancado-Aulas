CREATE OR REPLACE FUNCTION fn_media_sal (p_salario NUMBER)
RETURN VARCHAR2 IS
BEGIN
    IF p_salario <= 2000 THEN
        RETURN 'baixo';
    ELSIF p_salario BETWEEN 2001 AND 6000 THEN
        RETURN 'médio';
    ELSE
        RETURN 'alto';
    END IF;
END;

SELECT fn_media_sal(7000) FROM dual;