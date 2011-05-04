DELETE FROM ss_option_group;
DELETE FROM ss_option_company;
DELETE FROM ss_option_time;

DELETE FROM ss_cat_menu_option;

SELECT setval('ss_cat_menu_option_option_id_seq',1, false);

iNSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --1
VALUES ('20','Inventario',NULL,NULL,NULL,40,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --2  
VALUES ('50','Ingresos&nbsp;y&nbsp;gastos',NULL,NULL,NULL,20,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --3  
VALUES ('60','Estadisticas',NULL,NULL,NULL,60,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --4 
VALUES ('70','Home&nbsp;Service',NULL,NULL,NULL,30,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --5 
VALUES ('80','Mano&nbsp;de&nbsp;Obra',NULL,NULL,NULL,30,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --6 
VALUES ('90','Auditoria',NULL,NULL,NULL,30,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --7
VALUES ('2030','Control de Ordenes de Compra',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --8
VALUES ('2050','Control de Inventario',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --9
VALUES ('2060','Reportes',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --10
VALUES ('5030','Semivariables',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --11 
VALUES ('5040','Reportes',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --12 
VALUES ('5050','Ventas',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --13
VALUES ('6010','Transacciones por AGEB',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --14
VALUES ('6020','Reportes',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --15
VALUES ('6030','Congelados',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --16
VALUES ('6050','Captura de volanteo',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --17
VALUES ('6060','Horarios',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --18
VALUES ('7030','Reportes',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --19
VALUES ('8030','Mano de Obra Semanal',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --20
VALUES ('8040','Planeaci&oacute;n',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --21
VALUES ('9010','Reportes',NULL,NULL,NULL,NULL,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --22
VALUES ('203015','Orden de Compra','/Inventory/PurchaseOrder/Entry/OrderYum.jsp','ifrMainContainer',NULL,500,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --23
VALUES ('205010','Transferencias de entrada/salida','/Inventory/Transfers/Entry/TransferYum.jsp','ifrMainContainer',NULL,500,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --24
VALUES ('205020','Inventario semanal','/Inventory/WeeklyInventory/Entry/InventoryYum.jsp','ifrMainContainer',NULL,500,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --25-----
VALUES ('206010','Inventario semanal','/Inventory/WeeklyInventory/Rpt/InventoryReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --26-----
VALUES ('206020','Transferencias de entrada','/Inventory/Transfers/Rpt/TransferReportYum.jsp?type=input','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --27-----
VALUES ('206030','Transferencias de salida','/Inventory/Transfers/Rpt/TransferReportYum.jsp?type=output','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --28
VALUES ('503010','Captura de facturas','/IncomeAndExpense/Semivariable/Entry/InvoiceMasterYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --29-----
VALUES ('503020','Reportes','/IncomeAndExpense/Semivariable/Rpt/InvoiceReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --30-----
VALUES ('504010','Comida de Empleados','/IncomeAndExpense/EmployeesMeal/Rpt/EmplMealReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --31
VALUES ('504020','Reporte de cajeros','/IncomeAndExpense/Cashiers/Entry/CashierYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --32
VALUES ('505010','Cierre Lote Tarj. Credito','/IncomeAndExpense/CreditCardBatch/Entry/CreditCardBatchYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --33
VALUES ('601010','Captura de HH y Objetivos','/Utilities/HouseHold/Entry/HouseholdYum.jsp','ifrMainContainer',NULL,500,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --34----- 
VALUES ('601020','Reportes','/Utilities/HouseHold/Rpt/HouseholdReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --35 
VALUES ('601030','Resumen de transacciones','/Utilities/Resume/Rpt/HouseHoldResumeYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --36-----    
VALUES ('602010','Reporte de cupones','/Statistic/CouponReport/Rpt/CouponReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --37-----
VALUES ('603020','Piezas por transaccion','/Graphics/PiecesAndTransactions/Rpt/PiecesReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --38-----
VALUES ('603030','No. transacciones','/Graphics/PiecesAndTransactions/Rpt/TransactionsReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --39-----
VALUES ('603040','Indice transacciones por fecha','/Graphics/PiecesAndTransactions/Rpt/TransactionsIndexReportYum.jsp?type=date','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --40-----
VALUES ('603050','Indice transacciones por dia','/Graphics/PiecesAndTransactions/Rpt/TransactionsIndexReportYum.jsp?type=day','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --41-----
VALUES ('603060','Indice transacciones por tendencia diaria','/Tendencies/Transactions/Rpt/TendenciesReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --42-----
VALUES ('603070','Captura de pzas/transac.','/Utilities/PiecesAndTransactions/Entry/TransPiecesYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --43
VALUES ('605010','Formato de captura','/Promotionalt/PromForm/Entry/TextPromForm.jsp','ifrMainContainer',NULL,500,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --44-----
VALUES ('606020','Resumen OD Horarios','/Statistic/ReportHours/Rpt/HourTransReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --45-----
VALUES ('703010','Cambio de destino','/HomeService/DestChange/Rpt/DestChangeReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --46-----
VALUES ('703020','Llamadas de excepcion','/HomeService/ConmCall/Rpt/ConmCallReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --47-----
VALUES ('703030','Llamadas de salida','/HomeService/CallOut/Rpt/CallOutReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --48
VALUES ('703040','Clientes potenciales','/HomeService/CustomReport/Entry/CustomYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --49
VALUES ('703050','Clientes Frecuentes','/HomeService/CustomFrec/Entry/CustomFrec.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --50
VALUES ('703060','Clientes potenciales por AGEB','/HomeService/CustomReportAgeb/Entry/CustomYumA.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --51
VALUES ('703070','Clientes Frecuentes por AGEB','/HomeService/CustomFrecAgeb/Entry/CustomFrecA.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --52-----
VALUES ('803010','Horarios Graficos','/CostOfLabor/Rpt/CostofLaborReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --53-----
VALUES ('804010','Marinado y Ajuste de Marinado','/Planning/MarinationPlan/Rpt/MarinationPlanReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --54-----
VALUES ('804020','Uso Ideal Diario','/Planning/IdealUse/Rpt/IdealUseReportYum.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --55
VALUES ('901030','Reporte ticket SUS','/Auditoria/AudiReport/Entry/AudiReport.jsp','ifrMainContainer',NULL,510,1);

INSERT INTO ss_cat_menu_option (option_org, option_desc, action_desc, target, option_key, icon_id, visible) --56 
VALUES ('901040','Reporte ticket Auditoria','/Auditoria/AudiPana/Entry/AudiPana.jsp','ifrMainContainer',NULL,510,1);


INSERT INTO ss_option_group VALUES (100,1);
INSERT INTO ss_option_group VALUES (100,2);
INSERT INTO ss_option_group VALUES (100,3);
INSERT INTO ss_option_group VALUES (100,4);
INSERT INTO ss_option_group VALUES (100,5);
INSERT INTO ss_option_group VALUES (100,6);
INSERT INTO ss_option_group VALUES (100,7);
INSERT INTO ss_option_group VALUES (100,8);
INSERT INTO ss_option_group VALUES (100,9);
INSERT INTO ss_option_group VALUES (100,10);
INSERT INTO ss_option_group VALUES (100,11);
INSERT INTO ss_option_group VALUES (100,12);
INSERT INTO ss_option_group VALUES (100,13);
INSERT INTO ss_option_group VALUES (100,14);
INSERT INTO ss_option_group VALUES (100,15);
INSERT INTO ss_option_group VALUES (100,16);
INSERT INTO ss_option_group VALUES (100,17);
INSERT INTO ss_option_group VALUES (100,18);
INSERT INTO ss_option_group VALUES (100,19);
INSERT INTO ss_option_group VALUES (100,20);
INSERT INTO ss_option_group VALUES (100,21);
INSERT INTO ss_option_group VALUES (100,22);
INSERT INTO ss_option_group VALUES (100,23);
INSERT INTO ss_option_group VALUES (100,24);
INSERT INTO ss_option_group VALUES (100,25);
INSERT INTO ss_option_group VALUES (100,26);
INSERT INTO ss_option_group VALUES (100,27);
INSERT INTO ss_option_group VALUES (100,28);
INSERT INTO ss_option_group VALUES (100,29);
INSERT INTO ss_option_group VALUES (100,30);
INSERT INTO ss_option_group VALUES (100,31);
INSERT INTO ss_option_group VALUES (100,32);
INSERT INTO ss_option_group VALUES (100,33);
INSERT INTO ss_option_group VALUES (100,34);
INSERT INTO ss_option_group VALUES (100,35);
INSERT INTO ss_option_group VALUES (100,36);
INSERT INTO ss_option_group VALUES (100,37);
INSERT INTO ss_option_group VALUES (100,38);
INSERT INTO ss_option_group VALUES (100,39);
INSERT INTO ss_option_group VALUES (100,40);
INSERT INTO ss_option_group VALUES (100,41);
INSERT INTO ss_option_group VALUES (100,42);
INSERT INTO ss_option_group VALUES (100,43);
INSERT INTO ss_option_group VALUES (100,44);
INSERT INTO ss_option_group VALUES (100,45);
INSERT INTO ss_option_group VALUES (100,46);
INSERT INTO ss_option_group VALUES (100,47);
INSERT INTO ss_option_group VALUES (100,48);
INSERT INTO ss_option_group VALUES (100,49);
INSERT INTO ss_option_group VALUES (100,50);
INSERT INTO ss_option_group VALUES (100,51);
INSERT INTO ss_option_group VALUES (100,52);
INSERT INTO ss_option_group VALUES (100,53);
INSERT INTO ss_option_group VALUES (100,54);
INSERT INTO ss_option_group VALUES (100,55);
INSERT INTO ss_option_group VALUES (100,56);

INSERT INTO ss_option_company VALUES (25,'KFC');
INSERT INTO ss_option_company VALUES (26,'KFC');
INSERT INTO ss_option_company VALUES (27,'KFC');
INSERT INTO ss_option_company VALUES (29,'KFC'); 
INSERT INTO ss_option_company VALUES (30,'KFC');
INSERT INTO ss_option_company VALUES (34,'KFC');
INSERT INTO ss_option_company VALUES (36,'KFC');
INSERT INTO ss_option_company VALUES (37,'KFC');
INSERT INTO ss_option_company VALUES (38,'KFC');
INSERT INTO ss_option_company VALUES (39,'KFC');
INSERT INTO ss_option_company VALUES (40,'KFC');
INSERT INTO ss_option_company VALUES (41,'KFC');
INSERT INTO ss_option_company VALUES (44,'KFC');
INSERT INTO ss_option_company VALUES (45,'KFC');
INSERT INTO ss_option_company VALUES (46,'KFC');
INSERT INTO ss_option_company VALUES (47,'KFC');
INSERT INTO ss_option_company VALUES (52,'KFC');
INSERT INTO ss_option_company VALUES (53,'KFC');
INSERT INTO ss_option_company VALUES (54,'KFC');

INSERT INTO ss_option_time VALUES(25,50,50);
INSERT INTO ss_option_time VALUES(26,50,50);
INSERT INTO ss_option_time VALUES(27,50,50);
INSERT INTO ss_option_time VALUES(29,50,50);
INSERT INTO ss_option_time VALUES(30,50,50);
INSERT INTO ss_option_time VALUES(34,50,50);
INSERT INTO ss_option_time VALUES(36,50,50);
INSERT INTO ss_option_time VALUES(37,50,50);
INSERT INTO ss_option_time VALUES(38,50,50);
INSERT INTO ss_option_time VALUES(39,50,50);
INSERT INTO ss_option_time VALUES(40,50,50);
INSERT INTO ss_option_time VALUES(41,50,50);
INSERT INTO ss_option_time VALUES(44,50,50);
INSERT INTO ss_option_time VALUES(45,50,50);
INSERT INTO ss_option_time VALUES(46,50,50); 
INSERT INTO ss_option_time VALUES(47,50,50);
INSERT INTO ss_option_time VALUES(52,50,50);
INSERT INTO ss_option_time VALUES(53,50,50);
INSERT INTO ss_option_time VALUES(54,50,50);

DROP VIEW ss_grl_vw_menu_struct;

CREATE VIEW ss_grl_vw_menu_struct AS


    SELECT user_id, cm.option_id, cm.option_org, cm.option_desc,
"substring"((cm.option_org)::text, 1, (length((cm.option_org)::text) - 2)) AS
father, CASE WHEN (cm.action_desc IS NULL) THEN (('show-menu=sm'::text ||
rtrim((cm.option_org)::text)))::character varying ELSE cm.action_desc END AS
"action", ci.icon_path, cm.target, text(oc.option_id) AS report_opts,
"isnull"(ss_grl_fn_get_exception(cm.option_id), ''::character varying) AS
report_exceptions, option_key,
"isnull"((ss_grl_fn_get_help_options(cm.option_id))::character varying,
''::character varying) AS help_options
FROM (((ss_cat_menu_option cm JOIN ss_option_group og ON ((cm.option_id =
og.option_id))) JOIN ss_user_group ug ON ((ug.group_id = og.group_id))) LEFT
JOIN ss_cat_icon ci ON ((cm.icon_id = ci.icon_id))   
LEFT JOIN ss_option_company oc ON (cm.option_id = oc.option_id AND oc.option_id=og.option_id)
) WHERE (visible = 1) 

UNION
SELECT user_id, cm.option_id, cm.option_org, cm.option_desc,
"substring"((cm.option_org)::text, 1, (length((cm.option_org)::text) - 2)) AS
father, CASE WHEN (cm.action_desc IS NULL) THEN (('show-menu=sm'::text ||
rtrim((cm.option_org)::text)))::character varying ELSE cm.action_desc END AS
"action", ci.icon_path, cm.target, '' AS report_opts,
"isnull"(ss_grl_fn_get_exception(cm.option_id), ''::character varying) AS
report_exceptions, option_key,
"isnull"((ss_grl_fn_get_help_options(cm.option_id))::character varying,
''::character varying) AS help_options FROM ((ss_cat_menu_option cm JOIN
ss_user_group ug ON ((cm.option_id = ug.option_id))) LEFT JOIN ss_cat_icon ci
ON ((cm.icon_id = ci.icon_id))) WHERE (visible = 1);

