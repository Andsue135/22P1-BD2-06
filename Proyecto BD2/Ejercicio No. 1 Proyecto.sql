Drop Function Valor_Tarifas;
DELIMITER //
Create Function bd_platvideo.Valor_Tarifas (
	id_tarifa int,
    p_valor Decimal(12,2)
)Returns Decimal(12,2) Deterministic
BEGIN
	declare v_id_tarifa int;
    declare v_id_valor decimal(12,2);
    
    set v_valor = p_valor;
    set v_id_tarifa = id_tarifa;
    
    if v_valor > 1 and v_valor <= 15.00 then
    select valor_real into v_valor from bd_platvideo.tbl_tarifas where id_tarifa = v_id_tarifa order by ABS(valor_real-v_valor) LIMIT 1;
    
    elseif v_valor < 1 then
    select valor_procentual into v_valor from bd_platvideo.tbl_tarifas where id_tarifa = v_id_tarifa order by ABS(valor_procentual-v_valor) LIMIT 1;
    
    else
    select valor_real, valor_procentual from bd_platvideo.tbl_tarifas where id_tarifa = v_id_tarifa;
    end if;
    
    return v_valor;
END //
DELIMITER ;