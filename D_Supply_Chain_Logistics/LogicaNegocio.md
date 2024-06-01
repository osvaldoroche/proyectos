# 1. Supply chain logistics problem

 Este es un proyecto realizado con los datos de Kaggle que se pueden encontrar en el siguiente link: https://www.kaggle.com/datasets/anisseezzebdi/supply-chain-logistics-problem

## 1.1. Problema

Un fabricante mundial de microchips proporciona un conjunto de datos reales de una red **logística de salida**, conocida como **logística de distribución**, que es la fase de la cadena de suministro que abarca la gestión de almacenamiento y distribución de mercaderías. La empresa ha facilitado datos sobre la demanda de 9.215 pedidos que deben enrutarse a través de su red de cadena de suministro de salida, compuesta por 19 almacenes, 11 puertos de origen y un puerto de destino. Los almacenes están limitados a un conjunto específico de productos que almacenan; además, algunos almacenes están dedicados a atender únicamente a un conjunto concreto de clientes. Además, los almacenes están limitados por el número de pedidos que pueden procesar en un solo día. Un cliente que hace un pedido decide qué tipo de nivel de servicio necesita: DTD (puerta a puerta), DTP (puerta a puerto) o CRF (carga remitida por el cliente). En el caso del CRF, el cliente organiza el flete y la empresa sólo incurre en los gastos de almacén. En la mayoría de los casos, un pedido puede enviarse a través de una de las 9 empresas de mensajería que ofrecen diferentes tarifas para distintas franjas de peso y niveles de servicio. Aunque la mayoría de los envíos se realizan por vía aérea, algunos pedidos se envían por tierra, en camiones. La mayoría de los transportistas ofrecen tarifas reducidas a medida que aumenta el peso total del envío en función de las distintas franjas de peso. Sin embargo, se sigue aplicando un cargo mínimo por envío. Además, los envíos más rápidos suelen ser más caros, pero ofrecen mayor satisfacción al cliente. El nivel de servicio al cliente queda fuera del ámbito de esta investigación.

## 1.2. Datos

El conjunto de datos se divide en siete tablas, una tabla para todos los pedidos a los que se les debe asignar una ruta (*tabla OrderList*) y seis archivos adicionales que especifican el problema y las restricciones. Por ejemplo, la tabla *FreightRates* describe todos los mensajeros disponibles, las brechas de peso para cada carril y las tarifas asociadas. La ruta de envío se refiere a la combinación de nivel de servicio, modo de transporte y mensajería entre dos puertos de envío. La tabla *PlantPorts* describe los enlaces permitidos entre los almacenes y los puertos de envío en el mundo real. Además, la tabla *ProductsPerPlant* enumera todas las combinaciones de productos y almacén admitidas. *VmiCustomers* contiene todos los casos extremos, en los que el almacén solo puede brindar soporte a clientes específicos, mientras que cualquier otro almacén que no figura en la lista puede abastecer a cualquier cliente . Además, *WhCapacities* enumera las capacidades de almacén medidas en el número de pedidos por día y *WhCosts* especifica el costo asociado al almacenamiento de los productos en un almacén determinado medido en dólares por unidad.


# 2. Problema

El fabricante de microchips necesita optimizar su red logística de salida para mejorar la eficiencia y reducir costos. La empresa enfrenta varios desafíos en la gestión de su cadena de suministro de salida, incluyendo la capacidad limitada de almacenes, la elección del mensajero adecuado, y la gestión de las tarifas de envío según el peso y el nivel de servicio requerido por el cliente. La complejidad aumenta debido a la diversidad de productos, las restricciones específicas de los almacenes, y las variaciones en las tarifas de los mensajeros.

## 2.1. Objetivo del proyecto

Desarrollar un dashboard en Power BI que ayude a los gerentes de la cadena de suministro a tomar decisiones informadas basadas en indicadores clave de rendimiento (KPIs). Este dashboard debe proporcionar una visión integral y detallada sobre el flujo de pedidos, costos de almacenamiento, tarifas de envío, y capacidades de los almacenes, permitiendo optimizar rutas de envío y minimizar costos.

## 2.2. Pregunta general

**¿Cuál es la manera más eficiente de enrutarse los 9225 ordenes disponibles?**

## 2.2. Preguntas especificas

**a) Capacidad de Almacenamiento**

1. ¿Qué porcentaje de la capacidad máxima está siendo utilizada en el almacen?
2. ¿Cuántos pedidos están pendientes por la falta de capacidad de almacenamiento?

**b) Costos de almacenamiento**

3. ¿Cuál es el costo total de almacenamiento en cada almacén?
4. ¿Cuál es el costo promedio de almacenamiento por unidad de producto en cada almacén?

**c) Eficiencia de Envío**

5. ¿Cuál es el costo de envío por pedido?
6. ¿Cuál es el costo de envío por peso total de los envíos?
7. ¿Cuál es el tiempo promedio desde que se procesa un pedido hasta que se entrega?

**d) Utilización de Mensajeros**

8. ¿Cuántos pedidos han sido gestionados por cada empresa de mensajería?
9. ¿Cuál es el costo promedio de envío por cada empresa de mensajería?

**e) Nivel de servicio**

10. ¿Cuántos pedidos están clasificados por cada tipo de nivel de servicio (DTD, DTP, CRF)?
11. ¿Qué nivel de servicio se asocia con la mayor satisfacción del cliente (basado en la elección de envíos más rápidos)?

**f) Optimización de rutas**

12. ¿Cómo afectan los cargos mínimos y las tarifas reducidas por peso a los costos totales de envío?
13. ¿Cuáles son las rutas de envío más eficientes en términos de costo y tiempo de entrega?

## 2.3. Indicadores necesarios

Se han identificado una serie de indicadores clave de rendimiento (KPI's) para responder las preguntas del problema en cada uno de los puntos:

**a) Capacidad de Almacenes:**

+ Pedidos Procesados vs. Capacidad Máxima: Mostrar el porcentaje de capacidad utilizada en cada almacén.

+ Pedidos Pendientes: Número de pedidos que no pudieron ser procesados debido a la falta de capacidad.

**b) Costos de Almacenamiento:**

+ Costo Total de Almacenamiento por Almacén: Costo acumulado de almacenamiento en cada almacén.

+ Costo Promedio por Unidad Almacenada: Costo promedio de almacenamiento por unidad de producto en cada almacén.

**c) Eficiencia de Envío:**

+ Costo de Envío por Pedido: Costo total del envío dividido por el número de pedidos.

+ Costo de Envío por Peso: Costo total del envío dividido por el peso total de los envíos.

+ Tiempo Promedio de Envío: Tiempo promedio desde que se procesa un pedido hasta que se entrega.

**d) Utilización de Mensajeros:**

+ Distribución de Envíos por Mensajero: Número de pedidos gestionados por cada empresa de mensajería.

+ Costo Promedio por Mensajero: Costo promedio de envío por cada empresa de mensajería.

**e) Nivel de Servicio:**

+ Distribución de Pedidos por Nivel de Servicio: Número de pedidos clasificados por DTD, DTP y CRF.

+ Satisfacción del Cliente (Proxy): Medida indirecta basada en la elección de nivel de servicio más rápido (asumido como mayor satisfacción).

**f) Optimización de Rutas:**

+ Cargos Adicionales por Peso: Análisis de cómo los cargos mínimos y las tarifas reducidas por peso afectan los costos totales.

+ Rutas más Eficientes: Identificación de rutas de envío que minimizan costos y tiempos de entrega.

# 3. Modelo de datos

## 3.1. Hechos

### fctOrderList

- Order ID **(PK)**: Número de orden a enrutar	
- Order Date: Fecha en que se realiza la orden
- Origin Port: 	Puerdo de salida de la orden
- Carrier: Transportista que traslada la orden
- TPT: Tiempo de rendimiento de la orden
- Service Level: Tipo de nivel de servicio
- Ship ahead day count: Cantidad de días adelantados de la orden
- Ship Late Day count: Cantidad de días de retraso de la orden
- Customer: Consumidor que registro la orden
- Product ID: ID del producto de la orden
- Plant Code: Código de la planta de dónde salio la orden
- Destination Port: Puerto de destino de la orden
- Unit quantity: Cantidad de unidades de la orden
- Weight: Peso de la orden

## 3.2. Dimensiones

### dimProduct

Combinación de productos y almacen admitidas. 

- Product ID: Id del producto
- Plant code: Código de la planta

### dimVimCustumers

Almacenes que brindan soporte a clientes espécificos.

- Custumers: 
- Plant code: 

### dimWhcost

El costo asociado al almacenamiento de los productos en un almacén determinado medido en dólares por unidad.

- Plant Code
- costUnit

### dimWhcapacities

Capacidad de almacén medidas en el número de pedidos por día.

- Plant code
- Daily capacity

### PlantPorts

Describe los enlaces permitidos entre los almacenes y los puertos de envío.

- Plant code
- Port

### FreightRates

Describe los mensajeros disponibles, las brechas de peso para cada carril y las tarifas asociadas.

- Carrier	
- orig_port_cd
- dest_port_cd	
- minm_wgh_qty	
- max_wgh_qty	
- svc_cd	
- minimum cost	
- rate	
- mode_dsc	
- tpt_day_cnt	
- Carrier type

## 3.3. Nuevo modelo de datos

El nuevo modelo de datos surge del proceso ETL que se llevara a cabo en Power Query, aunque es facilmente replicable en otros lenjuages como R o Python para un proceso más automatizado. Eso queda fuera de este proyecto. Las tablas resultantes del proceso ETL serán las que formen el modelo de datos, se espera que sean 7, una tabla de hechos (H) y 6 dimensiones (D):

1. Clientes (D)
2. Ordenes (H)
3. Productos (D)
5. Tipo de servicio (D)
6. Carrier (D)
7. Calendario (D)

## 3.4. Entidades Nuevas (Tablas)

### Custumers (D)

- custumer ID **(PK)**
- custumer_special = T/F

### Ordenes (H)

- order ID **(PK)**
- orderDate **(FK)**
- Service ID **(FK)**
- Custumer ID **(FK)**
- Product ID **(FK)**
- PortODCarrier ID **(FK)**
- TPT
- Ship ahead day count	
- Ship Late Day count
- Unit quantity	
- Weight

### Products

- Product ID **(PK)**
- PlantPortsDestino
- ProductPlant
- costUnitPlant
- dailyCapacityPlant
- PortsOrigin
- PortsDestin

### TipoServicio (D)

- Service ID **(PK)**

### Carriers (D)

- Carrier_ID 
- Modo_transporte
- CarrierType
- PortODCarrier **(PK)**
- minm_wgh_qty	
- max_wgh_qty
- minimumcost	
- rate
- tpt_day_cnt

### Calendar (D)

- Date **(PK)**
- day
- month
- year
- numSem
- trimes

## 3.5. Relaciones

+ Un **consumidor** pide una o más **ordenes** y una **orden** pertenece a un solo **consumidor**. (_M-1_)

+ Una **orden** tiene un **tipo de servicio** y a un **tipo de servicio** le pertenecen una o más **ordenes**. (_1-M_)

+ Una **orden** es llevada por un solo **mensajero** y a un **mensajero** le corresponden muchas **ordenes**. (_1-M_)

+ Una **orden** contiene uno o más **productos** y un **producto** pertenece a una sola **orden**. (_1-M_)

+ Una **orden** se hace en una **fecha** y a un **fecha** le corresponden muchas **ordenes**. (_1-M_)

## 3.6. Relaciones internas

+ Un **producto** se guarda en un **almacen** y un **almacen** guarda muchos **productos**. (_1-M_) (unir a tabla productos)

+ A un **almacen** le corresponde un **puerto** y a un **puerto** le corresponden muchos **almacenes**. (_1-M_) (unir a tabla productos)

## 3.6. Modelo relacional 

Se realizará dentro de PBI. De otra forma se podría hacer en SQL pero el modelo debería cambiar y normalizarse más. El modelo de datos final es el siguiente:

![Modelo relacional de la base de datos](C:/Users/DELL/Documents/GitHub/proyectos/D_Supply_Chain_Logistics/ModeloSCLP.png)











