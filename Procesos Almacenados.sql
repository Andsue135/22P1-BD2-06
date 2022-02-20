Drop Procedure if Exists SP_Guardar_Subscriptor;

/* Proceso No. 1: Guardar Subscriptor */
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

	set v_id_sub 		= p_id_subscriptor;
	set v_cod_sub	= p_codigo_subscriptor; 
	set v_nom				= p_nombres;
	set v_ape				= p_apellidos;
		
    update bd_sample.tbl_subscriptores
		set id_subscriptor = p_id_subscriptor;
        set codigo_subscriptor = p_codigo_subscriptor;
        set nombres = p_nombres;
		set apellidos = p_apellidos;
    
	commit;
End