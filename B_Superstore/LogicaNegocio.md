
# 1. Análisis de ventas en PBI

Este es una análisis de ventas a través de un modelado de datos en Power BI. Lo que haremos es una normalización de los datos proporcionados. Además entenderemos el problema cómo la optimización de los datos y la solución de las siguientes preguntas. De manera que la empresa  de comercio electrónico desea optimizar su estrategia de envío para aumentar la satisfacción del cliente y maximizar las ventas. Para lograr este objetivo, la empresa necesita analizar en profundidad su desempeño actual en términos de entregas.

## 1.1. Problemas

1. Tasa de entrega exitosa: Porcentaje de pedidos entregados correctamente en relación con el total de pedidos.

2. Porcentaje de ventas por método de envío: Proporción de ventas realizadas utilizando diferentes métodos de envío.

3. Análisis de la distribución geográfica de las ventas. Dónde hubo más venta y el metodo de envio más popular.

4. Participación de las ventas por categoría y subcategoria

5. Ganancias por ciudad obtenidas por mes. 

# 2. Modelo de datos

## 2.1. Hechos

### fctSales

- Row ID **(PK)**: Registro de la transacción
- Order ID: Código de orden
- Order Date: fecha de orden
- Sales: Monto de venta de la transacción
- Quantity: Cantidad de unidades vendidas
- Discount: Descuento por promoción de productos
- Profit: Ganancia por la transacción

- Ship ID **(FK)**
- Custumer ID **(FK)**
- Postal Code **(FK)**
- Product ID **(FK)**
- Date **(FK)**

## 2.2. Dimensiones

### dimShip

- Ship ID **(PK)**: ID del metodo de envio
- Ship Mode: Nombre del método de envio

### dimCustomer

- Customer ID **(PK)**: id del cliente
- Customer Name: nombre del cliente	
- Segment: tipo de cliente


### dimCountry

- Country: país de la venta	
- City: ciudad de la venta
- State	: estado de la venta
- Postal Code **(PK)**: código postal
- Region: region donde se realizo la venta

### dimProduct

- Product ID **(PK)**: iD del producto	
- Product Name: nombre del producto
- Category: categoria del producto
- Sub-Category: subcategoría del producto

### dimCalendar

- date **(PK)**: fecha en que se realizó la venta
- day: día en que se realizó la venta
- month: número de mes en que se realizó la venta
- monthName: nombre del mes
- weekMonth: semana del mes
- year: año

