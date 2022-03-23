Drop Function if exists bd_platvideo.Valor_Tarifas;
DELIMITER //
Create Function bd_platvideo.Valor_Tarifas (
	id_tarifa int,
    valor_numero decimal(12,2)
)Returns Decimal(12,2) Deterministic
BEGIN
	declare v_id_tarifa int;
    declare v_valor decimal(12,2) default 0;
    declare v_valorA decimal(12,2);
    declare v_valorB decimal(12,2);
    declare VN decimal(12,2);
      
    set v_id_tarifa = id_tarifa;
    set VN = valor_numero;
    
    if VN > 1 and VN <= 15.00 then
		set v_valorA = (select valor_real from bd_platvideo.tbl_tarifas where id_tarifa = v_id_tarifa order by ABS(valor_real -v_valor));
		return v_valorA;
    elseif VN < 1 then
		set v_valorB = (select valor_procentual from bd_platvideo.tbl_tarifas where id_tarifa = v_id_tarifa order by ABS(valor_procentual -v_valor));
		return v_valorB;
    else
		set v_valor = VN;
		return v_valor;
    end if;
    
END //
DELIMITER ;

select bd_platvideo.Valor_Tarifas(3,20) from bd_platvideo.tbl_tarifas;