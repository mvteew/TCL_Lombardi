CREATE DEFINER=`root`@`localhost` PROCEDURE `transaccion_en_clientes`()
BEGIN
   DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
    BEGIN
    ROLLBACK;
END;

START TRANSACTION;
INSERT INTO clientes (id, nombre, cp, direccion, telefono, localidad) VALUES (15, 'Bruno German', '8143', '24 de septiembre 6234', '011-135-1234', 'Montevideo');
INSERT INTO clientes (id, nombre, cp, direccion, telefono, localidad) VALUES (16, 'Iban Ramirez', '1942', 'garay 2134', '011-555-9134', 'Tierra Del Fuego');
COMMIT;
END

#en esta transaccion lo que quiero es que se inserten datos correctamente y si estan incorrectos haga un ROLLBACK