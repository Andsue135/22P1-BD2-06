     if id_factura = v_id_factura then
 update bd_sample.tbl_facturas 
		set v_id_factura 		= id_factura;
		set fecha_emision		= curdate();
		set v_id_subscriptor	= id_subscriptor;
		set v_numero_items 		= numero_items;
		set isv_total 			= (p_numero_items*p_precio_costo)*0.15 ;
		set subtotal			= (p_numero_items*p_precio_costo);
		set totapagar 			= (p_numero_items*p_precio_costo)*1.15;
else
insert into bd_sample.tbl_facturas ( 
		id_factura, fecha_emision, id_subscriptor, numero_items, isv_total, subtotal, totapagar  
	) values (
    
		v_id_factura, v_fecha_emision, v_id_subscriptor, v_numero_items, v_isv_total, v_subtotal, v_totapagar 
	);
end  if;