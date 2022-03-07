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
        
        set Cadena = concat(Cadena, "[",v_id_factura,", ",v_fecha_emision,", ",v_id_subscriptor, "], ");
        
	end while;
        
	select Cadena;
        
END;

Drop Procedure if exists SP_Registro_Tickets;
Create Procedure SP_Registro_Tickets(
	in p_fecha_inicio datetime
)
Begin
	
    declare v_id_factura int;
    declare v_Randomizer int;
    declare v_fecha_inicio datetime;
    declare v_orden int default 0;
    declare v_orden_Max int;
    
    set v_fecha_inicio = p_fecha_inicio;
    
    set v_orden_Max = (select max(orden) from bd_sample.tbl_facturas_selectas);
    
    while v_orden < v_orden_Max do
		set v_orden = v_orden + 1;
        
		select fecha_emision into v_fecha_inicio
		from bd_sample.tbl_facturas_selectas where orden = v_orden;
              
		select id_factura into v_id_factura 
        from bd_sample.tbl_facturas_selectas where orden = v_orden;
        
        set v_Randomizer = (select ceil( RAND()*(10000-0)+10000 ));
        
        insert into bd_sample.tbl_tickets_promo (
			idticket, idfactura, numero_random, fecha_creacion
        )values(
			v_orden, v_id_factura, v_Randomizer, v_fecha_inicio
        );
	end while;
    select * from bd_sample.tbl_tickets_promo;
End;
