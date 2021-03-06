/* Proceso No. 1: Guardar Subscriptor */
Drop Procedure if Exists SP_Guardar_Subscriptor;
Delimiter //
Create Procedure SP_Guardar_Subscriptor(
	in p_id_subscriptor 	int, 
    in p_codigo_subscriptor int,
    in p_nombres 			varchar(25),
    in p_apellidos 			varchar(25)
)

Begin
	declare  v_id_sub int; 
	declare  v_cod_sub int; 
	declare  v_nom varchar(25) ;
	declare  v_ape varchar(25); 

	set v_id_sub 	= p_id_subscriptor;
	set v_cod_sub	= p_codigo_subscriptor; 
	set v_nom		= p_nombres;
	set v_ape		= p_apellidos;
		
    update bd_sample.tbl_subscriptores
		set v_id_subscriptor = id_subscriptor;
        set v_codigo_subscriptor = codigo_subscriptor;
        set v_nombres = nombres;
		set v_apellidos = apellidos; 
    
	commit;
End;

/* Proceso No. 2: Guardar Producto */
Drop Procedure if Exists SP_Guardar_Producto;
Delimiter //
Create Procedure SP_Guardar_Producto(
	in p_id_producto 	int,
    in p_nombre			varchar(45),
    in p_descripcion	varchar(45),
    in p_precio_costo 	decimal(12,2),
    out p_precio_venta	decimal(12,2)
)

Begin
	declare v_id_producto int; 
	declare v_nom_prod varchar(45); 
	declare v_desc_prod varchar(45) ;
	declare v_precio_costo decimal(12,2);
    declare v_precio_venta decimal(12,2);

	set v_id_producto 		= p_id_producto;
	set v_nom_prod			= p_nombre; 
	set v_desc_prod			= p_descripcion;
	set v_precio_costo		= p_precio_costo;
    set v_precio_venta 		= p_precio_venta;
		
	set p_precio_venta = (p_precio_costo)*1.25;
        
    update bd_sample.tbl_productos
		set v_id_producto = id_producto;
        set v_nombre = nombre;
        set v_descripcion = descripcion;
        set v_precio_costo = precio_costo;
        set v_precio_venta = precio_venta; 
		
	commit;
End;

/* Proceso No. 3: Guardar Factura */

Drop Procedure if Exists SP_Guardar_Factura;
Delimiter //
Create Procedure SP_Guardar_Factura(
	in p_id_factura 	int,
    in p_fecha_emision	datetime,
    in p_id_subscriptor	int,
    in p_numero_items 	int,
    out p_isv_total		decimal(12,2),
	out p_subtotal		decimal(12,2),
    out p_totapagar		decimal(12,2),
    in p_precio_costo 	decimal(12,2)
)

Begin

	declare v_id_factura 		int;
    declare v_fecha_emision		datetime;
    declare v_id_subscriptor 	int;
    declare v_numero_items 		int;
    declare v_isv_total			decimal(12,2);
    declare v_subtotal			decimal(12,2);
    declare v_totapagar			decimal(12,2);
    declare v_precio_costo 		decimal(12,2);

	
	set v_id_factura 		= p_id_factura;
	set v_fecha_emision		= curdate();
	set v_id_subscriptor	= p_id_subscriptor;
	set v_numero_items 		= p_numero_items;
    set v_isv_total 		= (p_numero_items*p_precio_costo)*0.15;
    set v_subtotal			= (p_numero_items*p_precio_costo);
    set v_totapagar 		= (p_numero_items*p_precio_costo)*1.15;

        
	insert into bd_sample.tbl_facturas ( 
		id_factura, fecha_emision, id_subscriptor, numero_items, isv_total, subtotal, totapagar  
	) values (
		v_id_factura, v_fecha_emision, v_id_subscriptor, v_numero_items, v_isv_total, v_subtotal, v_totapagar 
	);

	commit;
End;

/* Proceso No. 4: Procesar Factura */

Drop Procedure if Exists SP_Procesar_Factura;
Delimiter //
Create Procedure SP_Procesar_Factura(
	in p_id_factura 	int,
    in p_fecha_emision	datetime,
    in p_id_subscriptor	int,
    in p_numero_items 	int,
    out p_isv_total		decimal(12,2),
    out p_subtotal		decimal(12,2),
    out p_totapagar		decimal(12,2),
    in p_precio_costo 	decimal(12,2),
    in p_id_producto 	int,
    in p_cantidad 		int
    )

Begin
/* Crear Proceso de Facturaci??n */
    declare v_id_factura 		int;
    declare v_fecha_emision		datetime;
    declare v_id_subscriptor	int;
    declare v_numero_items 		int;
    declare v_isv_total			decimal(12,2);
    declare v_subtotal			decimal(12,2);
    declare v_totapagar			decimal(12,2);
    declare v_precio_costo 		decimal(12,2);
    declare v_id_producto		int;
    declare v_cantidad			int;

    set v_id_factura 		= p_id_factura;
    set v_id_producto       = p_id_producto;
    set v_cantidad          = p_cantidad;
	set v_precio_costo      = p_precio_costo;
	set v_isv_total 		= (p_numero_items*p_precio_costo)*0.15;
	set v_subtotal			= (p_numero_items*p_precio_costo);
	set v_totapagar 		= (p_numero_items*p_precio_costo)*1.15;


/* Crear la factura */

    insert into bd_sample.tbl_items_factura(
		id_factura, id_producto, cantidad
    ) values ( 
		v_id_factura, v_id_producto, v_cantidad
    );

/* Update Facturas */
	update bd_sample.tbl_facturas 
		set v_id_factura 		= id_factura;
		set fecha_emision		= curdate();
		set v_id_subscriptor	= id_subscriptor;
		set v_numero_items 		= numero_items;
		set isv_total 			= (p_numero_items*p_precio_costo)*0.15 ;
		set subtotal			= (p_numero_items*p_precio_costo);
		set totapagar 			= (p_numero_items*p_precio_costo)*1.15;
	
	commit; 
End; 