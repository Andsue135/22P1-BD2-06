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
	declare  v_id_subscriptor int; 
	declare  v_cod_subscriptor int; 
	declare  v_nombres varchar(25) ;
	declare  v_apellidos varchar(25); 

	set v_id_subscriptor 	= p_id_subscriptor;
	set v_cod_subscriptor	= p_codigo_subscriptor; 
	set v_nombres			= p_nombres;
	set v_apellidos			= p_apellidos;
		
    if id_subscriptor = v_id_subscriptor then
    		update bd_sample.tbl_subscriptores
				set id_subscriptor = v_id_subscriptor;
				set codigo_subscriptor = v_codigo_subscriptor;
				set nombres = v_nombres;
				set apellidos = v_apellidos; 
			where id_subscriptor = v_id_subscriptor;
	else     
		insert into bd_sample.tbl_subscriptores ( 
				id_subscriptor, codigo_subscriptor, nombres, apellidos
			) values (
				v_id_subscriptor, v_codigo_subscriptor, v_nombres, v_apellidos
			);  
    end if;
	commit;
End;

/* Proceso No. 2: Guardar Producto */
Drop Procedure if Exists SP_Guardar_Producto;

/* Alter Table tbl_productos
Add Column Porcentaje decimal(12,2) after precio_costo */

/* Drop Table if Exists `tbl_productos_hist`;

CREATE TABLE `tbl_productos_hist` (
  `id_hist` int NOT NULL DEFAULT '0',
  `id_producto` int NOT NULL,
  `fecha_insercion` datetime DEFAULT NULL
 
) ; */

Delimiter //
Create Procedure SP_Guardar_Producto(
	in p_id_producto 	int,
    in p_nombre			varchar(45),
    in p_descripcion	varchar(45),
    in p_precio_costo 	decimal(12,2) default 0,
    in p_precio_venta	decimal(12,2)default 0,
    in p_id_hist 		int,
    in p_fecha_insercion datetime
)

Begin
	declare v_id_producto int; 
	declare v_nom_prod varchar(45); 
	declare v_desc_prod varchar(45) ;
	declare v_precio_costo decimal(12,2);
    declare v_precio_venta decimal(12,2);
    declare v_id_hist int;
    declare v_fecha_insercion datetime;

	set v_id_producto 		= p_id_producto;
	set v_nom_prod			= p_nombre; 
	set v_desc_prod			= p_descripcion;
	set v_precio_costo		= p_precio_costo;
    set v_precio_venta 		= p_precio_venta * 1.25;
    set v_id_hist			= p_id_hist;
    set v_fecha_insercion	= p_fecha_insercion;
	
        
	if id_producto = v_id_producto then
		case
			when v_precio_venta between 0 and 3.99 then set Porcentaje ='30%';
			when v_precio_venta between 4 and 7.99 then set Porcentaje ='50%';
			when v_precio_venta >= 8 then set Porcentaje ='60%';
			else set Porcentaje ='[Indefinido]';
		end case;
        
        update bd_sample.tbl_productos
			set id_producto = v_id_producto;
			set nombre = v_nombre;
			set descripcion = v_descripcion;
			set v_precio_costo = v_precio_costo;
			set v_precio_venta = v_precio_venta; 
			
		update bd_sample.tbl_productos_hist
			set id_hist = v_id_hist;
			set id_producto = v_id_producto;
			set fecha_insercion = v_fecha_insercion;
	else
		insert into bd_sample.tbl_productos_hist ( 
			id_hist, id_producto, fecha_insercion  
		) values (
			v_id_hist, v_id_producto, v_fecha_insercion 
		);
    end if;

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
    in p_isv_total		decimal(12,2),
	in p_subtotal		decimal(12,2),
    in p_totapagar		decimal(12,2),
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
    
    declare v_id_producto 		int;
    declare v_isv_prod 			decimal(12,2) default 0;
    declare v_total_prod   		decimal(12,2) default 0;
	declare v_subtotal_prod     decimal(12,2) default 0;
	declare v_precio_venta 		decimal(12,2) default 0;
    declare v_cantidad			int;
	
	set v_id_factura 		= p_id_factura;
	set v_fecha_emision		= p_fecha_emision;
	set v_id_subscriptor	= p_id_subscriptor;
	set v_numero_items 		= p_numero_items;
    set v_isv_total 		= p_isv_total;
    set v_subtotal			= p_subtotal;
    set v_totapagar 		= p_totapagar;
    

        
	if id_factura = v_id_factura then
		select precio_venta into v_precio_venta  
		from bd_sample.tbl_productos 
		where id_producto = v_id_producto;
    
		set v_subtotal_prod = (v_precio_venta*v_cantidad);
		set v_isv_prod		= (v_subtotal_prod*0.15);
		set v_total_prod	= v_subtotal_prod + v_isv_producto; 
    
		 update  bd_sample.tbl_facturas Set 
			numero_items 	= 	numero_items + v_cantidad,
			fecha_emision 	=	now(),
			isv_total   	=  	isv_total + v_isv,
			subtotal    	=   subtotal  + v_subtotal,
			totapagar		=   totapagar + v_total
		where id_factura = v_id_factura; 
	else
		insert into bd_sample.tbl_facturas ( 
				id_factura, fecha_emision, id_subscriptor, numero_items, isv_total, subtotal, totapagar  
			) values (
				v_id_factura, v_fecha_emision, v_id_subscriptor, v_numero_items, v_isv_total, v_subtotal, v_totapagar 
			);
	end  if;
	commit;
End;

/* Proceso No. 4: Procesar Factura */

Drop Procedure if Exists SP_Procesar_Factura;
Delimiter //
Create Procedure SP_Procesar_Factura(
	in p_id_factura 	int,
    in p_id_producto 	int,
    in p_cantidad 		int
    )

Begin
/* Crear Proceso de Facturación */
    declare v_id_factura 		int;
    declare v_id_producto		int;
    declare v_cantidad			int;
    
	declare v_id_producto 		int;
    declare v_isv_prod 			decimal(12,2) default 0;
    declare v_total_prod   		decimal(12,2) default 0;
	declare v_subtotal_prod     decimal(12,2) default 0;
	declare v_precio_venta 		decimal(12,2) default 0;
    declare v_cantidad			int;

    set v_id_factura 		= p_id_factura;
    set v_id_producto       = p_id_producto;
    set v_cantidad          = p_cantidad;

    if id_producto = v_id_producto then
		Call SP_Guardar_Factura();
    else
		insert into bd_sample.tbl_items_factura(
			id_factura, id_producto, cantidad
		) values ( 
			v_id_factura, v_id_producto, v_cantidad
		);

		end if;
    
	commit; 
End; 