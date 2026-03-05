declare

    genero varchar(1) := '&valor';

begin

    /*Usando if, elsif e else... Precisamos colocar no final end if;*/
    if upper(genero) = 'M' then
        dbms_output.put_line('O gênero informado é Masculino');
    elsif upper(genero) = 'F' then
        dbms_output.put_line('O gênero informado é Feminino');
    else
        dbms_output.put_line('Outros');
    end if;

end;