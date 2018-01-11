/*---Table 1--------Customer------*/
-- Create customer table as per schema in ERD
CREATE TABLE Customer_T5
(Customer_Id NUMBER(7) PRIMARY KEY,
Customer_First_Name VARCHAR2(80) NOT NULL,
Customer_Last_Name VARCHAR2(80) NOT NULL,
Street_Address VARCHAR2(80),
City VARCHAR2(30),
State VARCHAR2(40),
Zip_Code VARCHAR2(10),
Country VARCHAR2(50)
);

/*---Table 2---------Order------- */
--Create Order table as per schema in ERD
CREATE TABLE Order_T5
(Order_Id NUMBER(7) PRIMARY KEY,
Order_Place_Date DATE NOT NULL,
Order_Close_Date DATE,
Customer_Id  NUMBER(7) NOT NULL,
constraint Cust_Id_FK FOREIGN KEY (Customer_Id) REFERENCES Customer_T5 (Customer_Id));

/*---Table 3--------Product--*/
--Create Product table as per schema in ERD
CREATE TABLE Product_T5
(Product_Id NUMBER(7) PRIMARY KEY,
Product_Name VARCHAR2(50) NOT NULL,
Product_Category VARCHAR2(50) NOT NULL,
Product_Price NUMBER(20,2) NOT NULL,
constraint Prod_Cat check (Product_Category in ('Accessories', 'Apparels', 'Footwear', 'Others')));

/*---Table 4--------Order Line---*/
--Create Order Line table as per schema in ERD
CREATE TABLE Order_Line_T5
(Order_Line_Id NUMBER(7) PRIMARY KEY,
Order_Id NUMBER(7) NOT NULL,
Product_Id NUMBER(7) NOT NULL,
Order_Line_Close_Date DATE,
Product_Quantity NUMBER(3) NOT NULL,
constraint Order_Id_FK FOREIGN KEY (Order_Id) REFERENCES Order_T5 (Order_Id),
constraint Product_Id_FK FOREIGN KEY (Product_Id) REFERENCES Product_T5 (Product_Id));

/*---Table 5--------Complaint---*/
--Create Complaint table as per schema in ERD
CREATE TABLE Complaint_T5
(Complaint_Id NUMBER(7) PRIMARY KEY,
Complaint_Description VARCHAR2(400) NOT NULL,
Order_Line_Id NUMBER(7) NOT NULL,
Severity CHAR(1),
Complaint_Resolution CHAR(1),
Complaint_Open_Date DATE NOT NULL,
Complaint_Close_Date DATE,
constraint Order_Line_Id_FK FOREIGN KEY (Order_Line_Id) REFERENCES Order_Line_T5 (Order_Line_Id),
constraint Severity_CK check (Severity in ('H', 'L')),
constraint Com_Res_CK check (Complaint_Resolution in ('D', 'C', 'R')));

/*---Table 6--------Incentive---*/
--Create Incentive table as per schema in ERD
CREATE TABLE  Incentive_T5
(Incentive_Id NUMBER(7) PRIMARY KEY,
Incentive_Type VARCHAR2(40) NOT NULL,
Complaint_Id NUMBER(7) NOT NULL,
constraint Inc_Compl_Id_FK FOREIGN KEY (Complaint_Id) REFERENCES Complaint_T5 (Complaint_Id),
constraint Incentive_CK check (Incentive_Type in ('G', 'D'))
);

/*---Table 7------Gift Card---*/
--Create Gift Card table as per schema in ERD
CREATE TABLE Gift_Card_T5
(G_Incentive_Id NUMBER(7) PRIMARY KEY,
Amount NUMBER(7,2) NOT NULL,
Expiry_Date DATE NOT NULL,
constraint G_Inc_Id_FK FOREIGN KEY (G_Incentive_Id) REFERENCES Incentive_T5 (Incentive_Id)
);

/*---Table 8------Discount---*/
--Create Discount table as per schema in ERD
CREATE TABLE Discount_T5
(D_Incentive_Id NUMBER(7) PRIMARY KEY,
Discount decimal(5,4) NOT NULL,
constraint D_Inc_Id_FK FOREIGN KEY (D_Incentive_Id) REFERENCES Incentive_T5 (Incentive_Id),
constraint chk_Discount_Percent check (Discount between 0 and 1)
);

/*---Table 9-------Complaint Feedback----*/
--Create Complaint Feedback table as per schema in ERD
CREATE TABLE Complaint_Feedback_T5
(Complaint_Id NUMBER(7) PRIMARY KEY,
Feedback_Rating NUMBER(1),
Feedback_Description VARCHAR2(400),
constraint Feedback_Complaint_Id_FK FOREIGN KEY (Complaint_Id) REFERENCES Complaint_T5 (Complaint_Id),
constraint Rating_CK check (Feedback_Rating in (1, 2, 3, 4,5))
);

/*---Table 10------Logistic---*/
--Create Logistic table as per schema in ERD
CREATE TABLE  Complaint_Logistic_T5
(
Logistic_Id NUMBER(7) PRIMARY KEY,
Complaint_Id NUMBER(7),
Logistic_Type VARCHAR2(8) NOT NULL,
constraint Log_Complaint_Id_FK FOREIGN KEY (Complaint_Id) REFERENCES Complaint_T5 (Complaint_Id),
constraint Log_Type_CK check (Logistic_Type in ('Return', 'Deliver')));

/*---Table 11------Product Return---*/
--Create Product Return table as per schema in ERD
CREATE TABLE  Product_Return_T5
(
L_Return_Id NUMBER(7) PRIMARY KEY,
Return_Initiation_Date DATE NOT NULL,
Return_Close_Date DATE,
constraint Return_Id_FK FOREIGN KEY (L_Return_Id) REFERENCES Complaint_Logistic_T5 (Logistic_Id)
);

/*---Table 12------Product Deliver---*/
--Create Product Deliver table as per schema in ERD
CREATE TABLE  Product_Deliver_T5
(
L_Delivery_Id NUMBER(7) PRIMARY KEY,
Deliver_Initiation_Date DATE NOT NULL,
Deliver_Close_Date DATE,
Delivery_Type VARCHAR2(20) NOT NULL,
constraint Delivery_Id_FK FOREIGN KEY (L_Delivery_Id) REFERENCES Complaint_Logistic_T5 (Logistic_Id),
constraint Chk_Del_type CHECK (Delivery_Type in ('Express', 'Regular'))
);

/*---Table 13------Deny Complaint---*/
--Create Deny Complaint table as per schema in ERD
CREATE TABLE Deny_Complaint_T5
(
D_Complaint_id NUMBER(7) PRIMARY KEY,
Deny_Reason VARCHAR2(400) NOT NULL,
constraint Den_Complaint_FK FOREIGN KEY (D_Complaint_id) REFERENCES Complaint_T5 (Complaint_Id)
);

/*---Table 14------Cancel Order---*/
--Create Cancel Order table as per schema in ERD
CREATE TABLE Cancel_Order_T5
(
C_Complaint_id NUMBER(7) PRIMARY KEY,
C_Refund_Initiation_Date DATE NOT NULL,
C_Refund_Amount NUMBER(7,2) NOT NULL, 
constraint Can_Complaint_FK  FOREIGN KEY (C_Complaint_id) REFERENCES Complaint_T5 (Complaint_Id)
);

/*---Table 15------Replace Product---*/
--Create Replace Product table as per schema in ERD
CREATE TABLE Replace_Product_T5
(
R_Complaint_id NUMBER(7) PRIMARY KEY,
R_Refund_Initiation_Date DATE,
R_Refund_Amount NUMBER(7,2), 
constraint Ret_Complaint_FK  FOREIGN KEY (R_Complaint_id) REFERENCES Complaint_T5 (Complaint_Id)
);


--------------------------------------------INSERT Queries-----------------------------------------------------------------------
/* creating inputs to Customer_T5 table*/

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34576,'Arya','Stark','Oldtown, Braavos, #411','Girona','Catalonia','6103','Spain');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34577,'Rob','Stark','Dothraki Palace, #412','Bardenas Reales','Navarre','6106','Northern Ireland');


INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34578,'Hodor','Hodor','Dorne of Meereen, #514','Peñiscola','Valencia','7106','Scotland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
 values (34579,'Harvey' ,'Spectre','Bridge of Volantis, #537','Alcazaba','Almeria','6171','Morocco');
 
 INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values  (34580,'Kira','Light','Alhamila Mountains, #819','Pechina','Almeria','2106','Iceland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34581,'Ryuk','Kun','Canet de Mar, #911','Santa Florentina Castle','Barcelona','6104','Croatia');
 
INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)       
values (34582,'John','Snow','Tower of Joy, #202','Zafra','Guadalajara','6107','Malta');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34583,'Jack','Sparrow','Oldtown, Braavos, #413','Girona','Catalonia','6103','Spain');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34584,'Davy','Jones','Dothraki Palace, #402','Bardenas Reales','Navarre','6106','Northern Ireland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34585,'Sansa','Stark','Dorne of Meereen, #914','Peñiscola','Valencia','7106','Scotland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34586,'Joffery','Baratheon','Bridge of Volantis, #737','Alcazaba','Almeria','6171','Morocco');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34587,'Jamie','Lannister','Alhamila Mountains, #919','Pechina','Almeria','2106','Iceland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34588,'Tyrion','Lannister','Canet de Mar, #901','Santa Florentina Castle','Barcelona','6104','Croatia');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34589,'Katlyn','Stark','Tower of Joy, #222','Zafra','Guadalajara','6107','Malta');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34590,'Petyr','Baelish','Oldtown, Braavos, #416','Girona','Catalonia','6103','Spain');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34591,'Jorah','Mormont','Dothraki Palace, #422','Bardenas Reales','Navarre','6106','Northern Ireland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34592,'Tyene','Sand','Dorne of Meereen, #544','Peñiscola','Valencia','7106','Scotland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34593,'Daenerys','Targaryen','Bridge of Volantis, #597','Alcazaba','Almeria','6171','Morocco');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34594,'Lord','Varys','Alhamila Mountains, #019','Pechina','Almeria','2106','Iceland');

INSERT INTO Customer_T5 (Customer_Id, Customer_First_Name, Customer_Last_Name, Street_Address, City, State, Zip_Code, Country)
values (34595,'Khal','Drogo','Canet de Mar, #011','Santa Florentina Castle','Barcelona','6104','Croatia');

----------------------------------------------------------------------------------------------
/* Insert into Order_T5 table */

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES ( 3872848,TO_DATE('10/5/2016','MM/DD/YYYY'),TO_DATE('10/11/2016','MM/DD/YYYY'),34579);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3872960,TO_DATE(	'10/30/2016','MM/DD/YYYY'),TO_DATE(	'11/5/2016'	,'MM/DD/YYYY'),34580);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873072,TO_DATE(	'11/24/2016','MM/DD/YYYY'),TO_DATE(	'11/30/2016','MM/DD/YYYY'),34581);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873184,TO_DATE(	'12/19/2016','MM/DD/YYYY'),TO_DATE(	'12/23/2016','MM/DD/YYYY'),34582);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873296,TO_DATE(	'1/13/2017'	,'MM/DD/YYYY'),TO_DATE(	'1/17/2017'	,'MM/DD/YYYY'),34583);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873408,TO_DATE(	'11/26/2017','MM/DD/YYYY'),TO_DATE(	'11/28/2017','MM/DD/YYYY'),34584);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873520,TO_DATE(	'3/4/2017','MM/DD/YYYY'),TO_DATE(	'3/8/2017'	,'MM/DD/YYYY'),34585);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873632,TO_DATE(	'3/29/2017'	,'MM/DD/YYYY'),TO_DATE(	'3/31/2017'	,'MM/DD/YYYY'),34586);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873744,TO_DATE(	'4/23/2017'	,'MM/DD/YYYY'),TO_DATE(	'4/25/2017'	,'MM/DD/YYYY'),34587);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873856,TO_DATE(	'11/20/2017','MM/DD/YYYY'),TO_DATE(	'11/23/2017','MM/DD/YYYY'),34588);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3873968,TO_DATE('6/12/2017'	,'MM/DD/YYYY'),TO_DATE(	'6/14/2017'	,'MM/DD/YYYY'),34589);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3874080,TO_DATE(	'11/26/2017','MM/DD/YYYY'),NULL,34590);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3874192,TO_DATE(	'11/12/2017	','MM/DD/YYYY'),NULL,34591);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3874304,TO_DATE(	'11/15/2017	','MM/DD/YYYY'),NULL,34592);

INSERT INTO Order_T5 (Order_ID, Order_Place_Date, Order_Close_Date, Customer_Id)
VALUES(3874416,TO_DATE(	'11/27/2017','MM/DD/YYYY'),NULL,34593);

----------------------------------------------------------------------------------

/* Insert into Product_T5 table */

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (1,'T-Shirts','Apparels',20);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (2,'Tops','Apparels',30);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (3,'Jeans','Apparels',50);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (4,'Trousers','Apparels',45);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (5,'Boots','Footwear',26);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (6,'Sandals','Footwear',16);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (7,'Shoes','Footwear',36);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (8,'Slippers','Footwear',31);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (9,'Locket','Accessories',5);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (10,'Watch','Accessories',25);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (11,'Bracelets','Accessories',6);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (12,'Belts','Accessories',8);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (13,'Paintings','Others',100);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (14,'Lamps','Others',50);

INSERT INTO Product_T5 (Product_ID, Product_Name, Product_Category, Product_Price) 
values (15,'Candles','Others',10);

------------------------------------------------------------------------------------------------------------------------
--Insert into Order Line table
INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2601328	,	3872848	,	2	,	TO_DATE(	'10/8/2016'	,	'MM/DD/YYYY'	)	,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2601329	,	3872848	,	4	,	TO_DATE(	'10/10/2016'	,	'MM/DD/YYYY'	)	,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2603792	,	3873072	,	7	,	TO_DATE(	'11/27/2016'	,	'MM/DD/YYYY'	)	,	2	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2605024	,	3873184	,	3	,	TO_DATE(	'12/18/2016'	,	'MM/DD/YYYY'	)	,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2605025	,	3873184	,	15	,	TO_DATE(	'12/21/2016'	,	'MM/DD/YYYY'	)	,	3	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2607488	,	3873408	,	14	,	TO_DATE(	'2/9/2017'	,	'MM/DD/YYYY'	)	,	2	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2608720	,	3873520	,	13	,	TO_DATE(	'3/6/2017'	,	'MM/DD/YYYY'	)	,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2609952	,	3873632	,	11	,	TO_DATE(	'3/29/2017'	,	'MM/DD/YYYY'	)	,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2611184	,	3873744	,	8	,	TO_DATE(	'4/23/2017'	,	'MM/DD/YYYY'	)	,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2612416	,	3873856	,	3	,	TO_DATE(	'5/18/2017'	,	'MM/DD/YYYY'	)	,	2	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2613648	,	3873968	,	6	,	TO_DATE(	'6/12/2017'	,	'MM/DD/YYYY'	)	,	3	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2614880	,	3874080	,	10	,		NULL		,	2	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2616112	,	3874192	,	11	,		NULL		,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2617344	,	3874304	,	10	,		NULL		,	1	);

INSERT INTO Order_Line_T5 (Order_Line_ID, Order_ID, Product_ID, Order_Line_Close_Date, Product_Quantity)
VALUES 	(	2618576	,	3874416	,	12	,		NULL		,	2	);

------------------------------------------------------------------------------------------------------------------------------------
--Insert into Complaint table
INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775054,'Ordered small size but delivered medium size',2601328,'H','R',TO_DATE(	'10/14/2016'	,'MM/DD/YYYY'),TO_DATE(	'10/18/2016','MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775158,'Shoe color is not as per the product description',2603792,'H','R',TO_DATE(	'12/5/2016'	,'MM/DD/YYYY'),TO_DATE(	'12/10/2016'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775208,'Defective Piece',2605024,'L','R',TO_DATE(	'12/26/2016'	,'MM/DD/YYYY'),TO_DATE(	'12/30/2016'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775209,'Broken Candles',2605025,'L','R',TO_DATE(	'12/28/2016'	,'MM/DD/YYYY'),TO_DATE(	'1/2/2017'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775312,'Lamp has scratches and stand is broken',2607488,'H',null,TO_DATE(	'11/28/2017'	,'MM/DD/YYYY'),NULL);

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775362,'Painting size is incorrect',2608720,'L','D',TO_DATE(	'3/14/2017'	,'MM/DD/YYYY'),TO_DATE(	'3/15/2017'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775414,'Defective and poor finishing',2609952,'H','C',TO_DATE(	'4/6/2017'	,'MM/DD/YYYY'),TO_DATE(	'4/7/2017'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775466,'Size mismatch',2611184,'L','C',TO_DATE(	'5/1/2017'	,'MM/DD/YYYY'),TO_DATE(	'5/2/2017'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775516,'Waist size of the product is not fitting'  ,2612416,'L',null,TO_DATE(	'11/25/2017'	,'MM/DD/YYYY'),NULL);

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775568,'I ordered grey but now I want blue',2613648,'L','D',TO_DATE(	'6/14/2017'	,'MM/DD/YYYY'),TO_DATE(	'6/14/2017'	,'MM/DD/YYYY'));

INSERT INTO Complaint_T5 (Complaint_ID, Complaint_Description, Order_Line_ID, Severity, Complaint_Resolution, Complaint_Open_Date, Complaint_Close_Date)
VALUES (1775620,'As per the description, discount of 20% was offered but actual discount offer is 5%',2614880,'H',null,TO_DATE(	'11/29/2017'	,'MM/DD/YYYY'),NULL);

--------------------------------------------------------------------------------------------------------------------
--Insert into Incentive table
INSERT INTO Incentive_T5 (Incentive_Id, Incentive_Type, Complaint_Id)
VALUES (1775372,'D',1775312);

INSERT INTO Incentive_T5 (Incentive_Id, Incentive_Type, Complaint_Id)
VALUES (1775680,'G',1775620);

---------------------------------------------------------------------------------------------------------------------------
--Insert into Gift Card table
INSERT INTO Gift_Card_T5(G_Incentive_ID, Amount, Expiry_Date)
VALUES (1775680,100,TO_DATE('1/1/2018','MM/DD/YYYY'));

------------------------------------------------------------------------------------------------------------------------------
--Insert into Discount table
INSERT INTO Discount_T5 (D_Incentive_ID, Discount)
VALUES (1775372,0.0500);

-----------------------------------------------------------------------------------------------------
--Insert into Complaint Feedback table
INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775054	,4,	'Satisfied. Best Service ever');

INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775158	,5,	'Highly Satisifed. Thanks for all the support');

INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775208	,2,	NULL);

INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775209	,2,	'Not Satisfied. This is not how you treat your loyal customers');

INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775362	,1,	NULL);

INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775414	,2,	'Thanks for considering the request');

INSERT INTO Complaint_feedback_t5(Complaint_id, Feedback_Rating, Feedback_Description)
VALUES (1775466	,2,	NULL);

-----------------------------------------------------------------------------------------------------------------------------
--Insert into Complaint Logistic table
INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756342	,1775414,'Return');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756345	,1775466,'Return');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756348	,1775054,'Return');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756351	,1775158,'Return');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756354	,1775208,'Return');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756357	,1775209,'Return');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756360	,1775054,'Deliver');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756363	,1775158,'Deliver');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756366	,1775208,'Deliver');

INSERT INTO Complaint_logistic_t5(Logistic_id, Complaint_id, Logistic_Type)
VALUES (1756369	,1775209,'Deliver');

----------------------------------------------------------------------------------------------------------------------
--Insert into Product Delivery table
INSERT INTO Product_Deliver_T5 (L_Delivery_Id, Deliver_Initiation_Date, Deliver_Close_Date, Delivery_Type)
VALUES (1756360,TO_DATE('10/15/2016','MM/DD/YYYY'),TO_DATE('10/16/2016','MM/DD/YYYY'),'Express');

INSERT INTO Product_Deliver_T5 (L_Delivery_Id, Deliver_Initiation_Date, Deliver_Close_Date, Delivery_Type)
VALUES (1756363,TO_DATE('12/6/2016'	,'MM/DD/YYYY'),TO_DATE('12/7/2016','MM/DD/YYYY'),'Express');

INSERT INTO Product_Deliver_T5 (L_Delivery_Id, Deliver_Initiation_Date, Deliver_Close_Date, Delivery_Type)
VALUES (1756366,TO_DATE('12/27/2016','MM/DD/YYYY'),TO_DATE('12/28/2016','MM/DD/YYYY'),'Regular');

INSERT INTO Product_Deliver_T5 (L_Delivery_Id, Deliver_Initiation_Date, Deliver_Close_Date, Delivery_Type)
VALUES (1756369,TO_DATE('12/29/2016','MM/DD/YYYY'),TO_DATE('12/30/2016','MM/DD/YYYY'),'Regular');

-----------------------------------------------------------------------------------------------------------------
--Insert into Product Return table
INSERT INTO Product_Return_T5(L_Return_Id, Return_Initiation_Date, Return_Close_Date)
VALUES (1756342,TO_DATE('4/6/2017','MM/DD/YYYY'),TO_DATE('4/6/2017','MM/DD/YYYY'));

INSERT INTO Product_Return_T5(L_Return_Id, Return_Initiation_Date, Return_Close_Date)
VALUES (1756345,TO_DATE('5/1/2017','MM/DD/YYYY'),TO_DATE('5/1/2017','MM/DD/YYYY'));	

INSERT INTO Product_Return_T5(L_Return_Id, Return_Initiation_Date, Return_Close_Date)
VALUES (1756348,TO_DATE('10/15/2016','MM/DD/YYYY'),TO_DATE(	'10/16/2016','MM/DD/YYYY'));

INSERT INTO Product_Return_T5(L_Return_Id, Return_Initiation_Date, Return_Close_Date)
VALUES (1756351,TO_DATE('12/6/2016'	,'MM/DD/YYYY'),TO_DATE(	'12/7/2016'	,'MM/DD/YYYY'));

INSERT INTO Product_Return_T5(L_Return_Id, Return_Initiation_Date, Return_Close_Date)
VALUES (1756354,TO_DATE('12/27/2016','MM/DD/YYYY'),TO_DATE(	'12/28/2016','MM/DD/YYYY'));

INSERT INTO Product_Return_T5(L_Return_Id, Return_Initiation_Date, Return_Close_Date)
VALUES (1756357,TO_DATE('12/29/2016','MM/DD/YYYY'),TO_DATE(	'12/30/2016','MM/DD/YYYY'));

-----------------------------------------------------------------------------------------------------------------
--Insert into Deny Complaint table
INSERT INTO Deny_Complaint_T5(D_COMPLAINT_ID, DENY_REASON)
VALUES (1775362,'Product is as per description');

INSERT INTO Deny_Complaint_T5(D_COMPLAINT_ID, DENY_REASON)
VALUES (1775568,'Stock is not available');

-----------------------------------------------------------------------------------------------
--Insert into cancel order table
INSERT INTO cancel_order_t5(C_COMPLAINT_ID, C_REFUND_INITIATION_DATE,C_REFUND_AMOUNT)
VALUES (1775414,TO_DATE('04/05/2017','MM/DD/YYYY'),6);

INSERT INTO cancel_order_t5(C_COMPLAINT_ID, C_REFUND_INITIATION_DATE,C_REFUND_AMOUNT)
VALUES (1775466,TO_DATE('05/01/2017','MM/DD/YYYY'),31);

---------------------------------------------------------------------------------------------
--Insert into Replace Product table
INSERT INTO replace_product_t5(R_COMPLAINT_ID, R_REFUND_INITIATION_DATE,R_REFUND_AMOUNT)
VALUES (1775054,null,null);

INSERT INTO replace_product_t5(R_COMPLAINT_ID, R_REFUND_INITIATION_DATE,R_REFUND_AMOUNT)
VALUES (1775158,null,null);

INSERT INTO replace_product_t5(R_COMPLAINT_ID, R_REFUND_INITIATION_DATE,R_REFUND_AMOUNT)
VALUES (1775208,null,null);

INSERT INTO replace_product_t5(R_COMPLAINT_ID, R_REFUND_INITIATION_DATE,R_REFUND_AMOUNT)
VALUES (1775209,null,null);

commit;
