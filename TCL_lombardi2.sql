CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_venta`(
    IN p_factura VARCHAR(30),
    IN p_fecha DATE,
    IN p_monto DECIMAL(12,1),
    IN p_id_cliente INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO ventas (factura, fecha, monto, id_clientes)
    VALUES (p_factura, p_fecha, p_monto, p_id_cliente);

    UPDATE stock SET cantidad = cantidad - p_cantidad
    WHERE id = p_id_producto;

    INSERT INTO pagos (factura, id_cliente, id_producto, fecha, precio, cantidad)
    VALUES (p_factura, p_id_cliente, p_id_producto, p_fecha, p_monto, p_cantidad);

    COMMIT;
END
#en esta transaccion quiese cumplir 3 objetivos; 1)insertar una nueva venta en la tabla de ventas, 2) actualiza la cantidad de stock disponible para el producto vendido, 3) inserta un nuevo registro en la tabla de pagos y si ocurre algun error se ejecuta el bloque "DECLARE EXIT HANDLER FOR SQLEXCEPTION" que ejecutara un ROLLBACK y si todo sale bien se ejecuta el COMMIT