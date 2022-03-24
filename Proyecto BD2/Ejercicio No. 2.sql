Drop Procedure if exists SP_Generar_Facturas;
Delimiter //
Create Procedure SP_Generar_Facturas(
	in p_id_suscriptor int,
    in p_id_cat int
)
Begin
    declare v_costo_catalogo decimal(12,2);
    declare fecha_pago_inicio datetime;
    declare fecha_pago_final datetime;
    declare v_cantidad int;
    declare v_monto decimal(12,2);
    declare v_subtotal decimal(12,2);
    declare v_isv decimal(12,2);
    declare v_total decimal(12,2);
    declare v_fecha_inicio datetime;
    declare v_fecha_final datetime;
    
    declare v_id_orden,v_id_suscriptor, v_id_factura, v_id_cargo, v_id_cat int default 0;
    
    declare i int default 0;
    
    set v_fecha_inicio = current_date();
    set v_fecha_final = (select date_add(v_fecha_inicio, INTERVAL 20 DAY));
	set v_id_suscriptor = p_id_suscriptor;
    set v_id_cat = p_id_cat;
    
    set v_cantidad = (select count(Tbl1.iid_cat) from bd_platvideo.tbl_cat_prods Tbl1 left join bd_platvideo.tbl_catalogo Tbl2 on Tbl2.id_cat = Tbl1.iid_cat where id_cat = v_id_cat);
    set v_costo_catalogo = (select sum(Tbl2.precio_venta) from bd_platvideo.tbl_cat_prods Tbl1 left join bd_platvideo.tbl_catalogo Tbl2 on Tbl2.id_cat = Tbl1.iid_cat where id_cat = v_id_cat);
    
    set v_monto = (v_cantidad * v_costo_catalogo);
    set v_isv = (v_cantidad * v_costo_catalogo) * 0.15;
    set v_total = (v_cantidad * v_costo_catalogo) * 1.15;
    
    if v_id_usuario is not null then
		set v_costo_catalogo = v_costo_catalogo - (v_costo_valor * 0.10);
		set v_monto = (v_cantidad * v_costo_catalogo);
		set v_isv = (v_cantidad * v_costo_catalogo) * 0.15;
		set v_total = (v_cantidad * v_costo_catalogo) * 1.15;
	end if;
	if edad > 65 then
		set v_costo_catalogo = v_costo_catalogo - (v_costo_valor * 0.25);
		set v_monto = (v_cantidad * v_costo_catalogo);
		set v_isv = (v_cantidad * v_costo_catalogo) * 0.15;
		set v_total = (v_cantidad * v_costo_catalogo) * 1.15;
	end if;
    
	insert into bd_platvideo.tbl_cartera (
        id_orden, id_cat, id_suscriptor, fecha_ingreso, fecha_pago
	) values(
        v_id_orden, v_id_cat, v_id_suscriptor, v_fecha_inicio, v_fecha_final 
	);
    
    insert into bd_platvideo.tbl_fact_detalle (
        id_factura, id_cargo, cantidad, monto, subtotal, isv, total_cargo, fecha_ingreso
	) values(
        v_id_factura, v_id_cargo, v_cantidad, v_monto, v_isv, v_total, v_fecha_inicio
	);
    commit;
	
    
End;