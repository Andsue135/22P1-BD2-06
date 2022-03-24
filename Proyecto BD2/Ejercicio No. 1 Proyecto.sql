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
   
    case
		when id_tarifa = 1 then
			if VN > 12.51 and VN <= 15.00 then
            set v_valorA = (select valor_real from bd_platvideo.tbl_tarifas where id_tarifa = 1 LIMIT 1);
			return v_valorA;
            elseif VN > 0.1251 and VN <= 0.15 then
			set v_valorB = (select valor_procentual from bd_platvideo.tbl_tarifas where id_tarifa = 1 LIMIT 1);
			return v_valorB;
            
            end if;
		when id_tarifa = 2 then
			if VN > 1 and VN <= 10.00 then
            set v_valorA = (select valor_real from bd_platvideo.tbl_tarifas where id_tarifa = 2 LIMIT 1);
			return v_valorA;
            elseif VN <= 0.1 then
			set v_valorB = (select valor_procentual from bd_platvideo.tbl_tarifas where id_tarifa = 2 LIMIT 1);
			return v_valorB;
           
            end if;
		when id_tarifa = 3 then
			if VN > 22.51 and VN <= 25.00 then
            set v_valorA = (select valor_real from bd_platvideo.tbl_tarifas where id_tarifa = 3 LIMIT 1);
			return v_valorA;
            elseif VN <= 0.25 and VN > 0.2251 then
			set v_valorB = (select valor_procentual from bd_platvideo.tbl_tarifas where id_tarifa = 3 LIMIT 1);
			return v_valorB;
            
            end if;
		when id_tarifa = 4 then
			if VN > 17.51 and VN <= 20.00 then
            set v_valorA = (select valor_real from bd_platvideo.tbl_tarifas where id_tarifa = 4 LIMIT 1);
			return v_valorA;
            elseif VN <= 0.20 and VN >= 0.1751 then
			set v_valorB = (select valor_procentual from bd_platvideo.tbl_tarifas where id_tarifa = 4 LIMIT 1);
			return v_valorB;
            end if;
		end case;
        
END //
DELIMITER ;


select bd_platvideo.Valor_Tarifas(3,0.23694) from bd_platvideo.tbl_tarifas;