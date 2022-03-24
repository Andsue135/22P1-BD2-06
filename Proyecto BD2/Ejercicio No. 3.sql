Drop Procedure if exists Fechas_Ciclo;
DELIMITER //
Create Procedure Fechas_Ciclo (
    in p_nombres varchar(45), 
    in p_apellidos varchar(45), 
    in p_telefono varchar(45), 
    in p_email varchar(45), 
    in p_usuario varchar(45),
    in p_contrasena varchar(400),
    in p_fechanacimiento datetime,
    in p_edad int,
    in p_fecha_inrgreso datetime
)
BEGIN
	declare v_fecha_inicio, v_fecha_final, v_fechanacimiento datetime;
    declare v_nombres, v_apellidos, v_telefono, v_email, v_usuario varchar(45);
    declare v_contrasena varchar(400);
    declare v_idciclo, v_edad int;
    declare v_id_suscriptor int default 0;
      
	set v_nombres = p_nombres;
    set v_apellidos = p_apellidos;
    set v_telefono = p_telefono;
    set v_email = p_email;  
    set v_usuario = p_usuario; 
    set v_contrasena = p_contrasena; 
    set v_fechanacimiento = p_fechanacimiento; 
    set v_edad = p_edad; 
      
    set v_fecha_inicio = p_fecha_inrgreso;
	set v_fecha_final = (select date_add(v_fecha_inicio, INTERVAL 20 DAY));
    
    case
		when v_fecha_inicio between day('0000-00-01') and day('0000-00-07') then set v_idciclo = 1;
        when v_fecha_inicio between day('0000-00-08') and day('0000-00-17') then set v_idciclo = 2;
        when v_fecha_inicio between day('0000-00-18') and day('0000-00-22') then set v_idciclo = 3;
        when v_fecha_inicio between day('0000-00-23') and day('0000-00-27') then set v_idciclo = 4;
        when v_fecha_inicio between day('0000-00-28') and day('0000-00-31') then set v_idciclo = 5;
    end case;
   
	if id_suscriptor is null then
		insert into bd_platvideo.tbl_suscriptores(
        id_suscriptor, nombres, apellidos, telefono, email, usuario, contrasena, fechanacimiento, edad, fecha_inrgreso, idciclo
        ) values(
        v_id_suscriptor + 1, v_nombres, v_apellidos, v_telefono, v_email, v_usuario, v_contrasena, v_fechanacimiento, v_edad, v_fecha_inrgreso, v_idciclo
        );
	elseif id_suscriptor is not null then
		update bd_platvideo.tbl_suscriptores
			set id_suscriptor = v_id_suscriptor + 1,
			nombres = v_nombres,
			apellidos = v_apellidos,
			telefono = v_telefono,
			email = v_email,  
			contrasena = v_contrasena, 
            usuario = v_usuario, 
			fechanacimiento = v_fechanacimiento, 
			edad = v_edad, 
            fecha_inrgreso = v_fecha_inicio
		where id_suscriptor = v_id_suscriptor;
	end if;
	commit;
END;

