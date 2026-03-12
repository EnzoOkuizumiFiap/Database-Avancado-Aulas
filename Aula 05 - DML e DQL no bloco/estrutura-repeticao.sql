
/* Loop (acho que tipo um do while) */
declare 
    v_contador number(2) := 1;
begin
    dbms_output.put_line('Usando Loop');
    loop
        dbms_output.put_line('Número: ' || v_contador);
        v_contador := v_contador + 1;
        exit when v_contador > 20;
    end loop;
end;



/* WHILE */
declare 
    v_contador number(2):= 1;
begin
    dbms_output.put_line('Usando While');
    while v_contador < 20 loop
        dbms_output.put_line('Número: ' || v_contador);
        v_contador := v_contador + 1;
    end loop;
end;



/* FOR */
declare 
    v_contador number(2):= 1;
begin
    dbms_output.put_line('Usando While');
    for v_contador in 1..20 loop
        dbms_output.put_line('Número: ' || v_contador);
    end loop;
end;



/* Exercício Tabuada */
declare 
    tabuada number := 2;
begin
    for tabuada in 1..10 loop 
        dbms_output.put_line(tabuada || ' x ' || 2 || ' = ' || tabuada*2);
    end loop;
end;


/* Exercício ímpar ou par */
declare
    v_contador number(2):= 1;
begin
    for v_contador in 1..10 loop
        if mod(v_contador, 2) = 0 then 
            dbms_output.put_line('Número é par: ' || v_contador);
        else
            dbms_output.put_line('Número é ímpar: ' || v_contador);
        end if;
    end loop;
end;
    
    






