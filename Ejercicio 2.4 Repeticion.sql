Drop PROCEDURE if exists SP_Crear_Cadena;
Delimiter //
CREATE PROCEDURE SP_Crear_Cadena()
BEGIN
    declare v_id_factura int;
    declare v_fecha_emision datetime;
    declare v_id_subscriptor int;
    declare i int default 0;
    
    declare Cadena varchar(500);
    
    set Cadena = "";
    
    while i < 5 do
		set i = i+1;
        
        select id_factura into v_id_factura
        from bd_sample.tbl_facturas where id_factura = i;
        
        select fecha_emision into v_fecha_emision
        from bd_sample.tbl_facturas where id_factura = i;
        
        select id_subscriptor into v_id_subscriptor
        from bd_sample.tbl_facturas where id_factura = i;
        
        set Cadena = concat(Cadena, "[",v_id_factura,", ",v_fecha_emision,", ",v_id_subscriptor, "] ");
        
	end while;
        
	select Cadena;
    
    
END;

call SP_Crear_Cadena();