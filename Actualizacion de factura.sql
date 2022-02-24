/* Proceso No. 4: Procesar Factura */

Drop Procedure if Exists SP_Procesar_Factura;
Delimiter //
Create Procedure SP_Procesar_Factura(
	in p_id_factura 	int,
    in p_fecha_emision	datetime,
    in p_id_subscriptor	int,
    in p_numero_items 	int,
    in p_isv_total		decimal(12,2),
    in p_subtotal		decimal(12,2),
    in p_totapagar		decimal(12,2),
    in p_precio_costo 	decimal(12,2),
    in p_id_producto int,
    in p_cantidad int
    )

Begin
/* Crear Proceso de Facturación */
    declare v_id_factura 	int;
    declare v_fecha_emision	datetime;
    declare v_id_subscriptor	int;
    declare v_numero_items 	int;
    declare v_isv_total		decimal(12,2);
    declare v_subtotal		decimal(12,2);
    declare v_totapagar		decimal(12,2);
    declare v_precio_costo 	decimal(12,2);
    declare v_id_producto int;
    declare v_cantidad int;

    set v_id_factura 		=p_id_factura;
    set v_id_producto       =p_id_producto;
    set v_cantidad          =p_cantidad;
	set v_precio_costo      =p_precio_costo;

#   Crear la factura 

    insert into bd_sample.tbl_items_factura(
		id_factura, id_producto, cantidad
    ) values ( 
		v_id_factura, v_id_producto, v_cantidad
    );



# ACTUALIZACION DE FACTURA
/* Update Facturas */
update bd_sample.tbl_facturas 
	set v_id_factura 		=p_id_factura;
	set v_fecha_emision		= curdate();
	set v_id_subscriptor	= p_id_subscriptor;
	set v_numero_items 		= p_numero_items;
    set v_isv_total 		= (p_numero_items*p_precio_costo)*0.15;
    set v_subtotal			= (p_numero_items*p_precio_costo);
    set v_totapagar 		= (p_numero_items*p_precio_costo)*1.15;
		 
         
         commit; 
         
		
         
         

End; 