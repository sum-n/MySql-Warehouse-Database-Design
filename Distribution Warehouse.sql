CREATE DATABASE warehouse;
USE warehouse;

CREATE TABLE Customer (
				Customer_Id Integer not null,
				Customer_Name Varchar (20) not null,
				Customer_Address Varchar (50) not null,
				Delivery_item Varchar (50) not null,
				Delivery_Id Integer not null,
				Delivery_Time Varchar (10) not null,
                Quantity Integer not null,
				Price Varchar (20) not null,
				Primary Key (Customer_Id),
				CONSTRAINT Check_Customer_Id CHECK(LENGTH(Customer_Id) = 8),
				CONSTRAINT Check_Cus_Delivery_Id CHECK(LENGTH(Delivery_Id) = 8)
				);
ALTER TABLE Customer
ADD CONSTRAINT Min_Quantity CHECK (Quantity > 0);
ALTER TABLE Customer add unique (Customer_Id);

CREATE TABLE Courier ( 
				Delivery_Id INTEGER not null,
				Destination VARCHAR (50) not null,
				Dept_Time VARCHAR (10) not null,
				Arrival_Time VARCHAR (20) not null,
               Primary Key (Delivery_Id),
               CONSTRAINT Check_Delivery_Id CHECK(LENGTH(Delivery_Id) = 8)
				);
ALTER TABLE Courier add unique (Delivery_Id);
                    
CREATE TABLE Shelf (
				Storage_Id Varchar (20) not null,
				Location Varchar (20) not null,
				Storage_Name Varchar (50) not null,
				Capacity Varchar (20) not null,
				Primary Key (Storage_Id),
				CONSTRAINT Quantity_Check CHECK(LENGTH(Capacity) <= 5000)
				);      
 
CREATE TABLE Staff (
				Staff_Id Integer not null,
				Staff_Name Varchar (20) not null,
				Date_of_Birth Varchar (10) not null,
				Staff_Address Varchar (50) not null,
				Job_Id Varchar (20) not null,
				Primary Key (Staff_Id),
				Foreign Key (Job_Id) References Shelf (Storage_Id),
				CONSTRAINT Check_Job_Id CHECK (Job_Id IN ('Elec0001', 'OutAcc0501', 'MuscDJ0007', 'HFHA0001', 'FaClAc01', 'HeBe001', 'GaToy01', 'HoFur123'))
				);                    
ALTER TABLE Staff add unique (Staff_Id);                   

CREATE TABLE Equipment ( 
				Equipment_Id VARCHAR (10) not null,
				Equipment_Name VARCHAR (50) not null,
				Equipment_Type VARCHAR (50) not null,
				User_Id INTEGER not null,
				Primary Key (Equipment_Id),
				Foreign Key (User_Id) References Staff (Staff_Id)
				);
                        
CREATE TABLE Supplier ( 
				Supplier_Id INTEGER not null,
				Supplier_Name VARCHAR (50) not null,
				Delivery_item Varchar (50) not null,
				Customer_Id Integer not null,
				Delivery_Time Varchar (10) not null,
				Phone_Num Varchar (20) not null,
				Primary Key (Supplier_Id),
				Foreign Key (Customer_Id) References Courier (Delivery_Id),
				CONSTRAINT Check_Supplier_Id CHECK(LENGTH(Supplier_Id) = 9)
				);
                    
CREATE TABLE Product ( 
				Product_SN INTEGER not null,
				Product_Name VARCHAR (50) not null,
				Total_Items INTEGER not null,
				Price VARCHAR (10) not null,
				Supplier_Id INTEGER not null,
              	Primary Key (Product_SN),
				Foreign Key (Supplier_Id) References Supplier (Supplier_Id),
				CONSTRAINT Check_Total_Items CHECK(LENGTH(Total_Items) > 0)
				);
                    
CREATE TABLE Product_Stock (
				Storage_Id Varchar (20) not null,
				Product_SN Integer not null,
				Primary Key (Storage_Id, Product_SN),
				Foreign Key (Storage_Id) References Shelf (Storage_Id),
				Foreign Key (Product_SN) References Product (Product_SN)
				);
                    
CREATE TABLE Product_Delivery (
				Delivery_Id INTEGER not null,
				Customer_Id Integer not null,
				Primary Key (Delivery_Id, Customer_Id),
				Foreign Key (Delivery_Id) References Courier (Delivery_Id),
				Foreign Key (Customer_Id) References Customer (Customer_Id)
				);     
                  

INSERT INTO Customer VALUES (12345678, 'PC Universe', '1 Parkview, Greenlanes, Dublin 3', 'Sony Headphones', 87654321, '12:30', 50, '€10,950.00');
INSERT INTO Customer VALUES (12345679, 'Cool Tech', '2 Seaview, Maryland, Dublin 5', 'Amazon Echo Dot', 87654322, '18:00', 30, '€899.70');
INSERT INTO Customer VALUES (12345680, 'Bag Life', '12 Moonwalk, Waterview, Dublin 1', 'Tommy Hilfiger Backpack', 87654323, '15:30', 20, '€1,290.80');
INSERT INTO Customer VALUES (12345681, 'Mulls Music', '53 Sideview, Chelsea Gardens, Dublin 2', 'Wooden Hand Drum', 87654324, '13:30', 15, '€346.35');
INSERT INTO Customer VALUES (12345682, 'Techo', '22 Northsides Park, Swords, Dublin', 'Elgato Stream Deck', 87654325, '11:30', 5, '€1,049.95');

INSERT INTO Courier VALUES (23456789, '1 Parkview, Greenlanes, Dublin 3', '06:00', '12:30');
INSERT INTO Courier VALUES (23456790, '2 Seaview, Maryland, Dublin 5', '06:30', '18:00');
INSERT INTO Courier VALUES (23456791, '12 Moonwalk, Waterview, Dublin 1', '07:30', '15:30');
INSERT INTO Courier VALUES (23456792, '53 Sideview, Chelsea Gardens, Dublin 2', '07:00', '13:30');
INSERT INTO Courier VALUES (23456793, '22 Northsides Park, Swords, Dublin', '08:00', '11:30');

INSERT INTO Shelf VALUES ('Elec0001', '2nd Level', 'Electronics & Office', 5000);
INSERT INTO Shelf VALUES ('Elec0002', '2nd Level', 'Electronics & Office', 1000);
INSERT INTO Shelf VALUES ('OutAcc0501', '1st Level', 'Outdoors & Accessories', 2500);
INSERT INTO Shelf VALUES ('MuscDJ0007', '3rd Level', 'Musical Instruments & DJ', 500);
INSERT INTO Shelf VALUES ('HFHA0001', '4th Level', 'Hi-Fi & Home Audio', 1000);
INSERT INTO Shelf VALUES ('FaClAc01', '3rd Level', 'Fashion, Clothing & Accessories', 5000);
INSERT INTO Shelf VALUES ('HeBe001', '3rd Level', 'Health & Beauty', 5000);
INSERT INTO Shelf VALUES ('GaToy01', '1st Level', 'Gaming & Toys', 4500);
INSERT INTO Shelf VALUES ('HoFur123', '0 Level', 'Home and Furniture', 700);

INSERT INTO Staff VALUES (0123456, 'Roxy Tollemache', '10/02/1990', '92 Water Rd, Saint Johns, South Dublin', 'Elec0001');
INSERT INTO Staff VALUES (0123457, 'Terry Brine', '16/10/1989', '66 High St, Saint Marks, Kilkenny', 'OutAcc0501');
INSERT INTO Staff VALUES (0123458, 'Michael Kennedy', '21/04/1995', '12 Kill Lane, View park, Waterford', 'MuscDJ0007');
INSERT INTO Staff VALUES (0123459, 'Peter Doyle', '27/02/1986', '47 Kenyon St, Nenagh, Dublin', 'HFHA0001');
INSERT INTO Staff VALUES (0123460, 'Alan McCarthy', '02/02/1998', 'Duffy Hill, Enniscorthy, South Dublin', 'FaClAc01');
INSERT INTO Staff VALUES (0123461, 'Conor Doyle', '07/03/1981', '104 Creagh Ct., Rathcoole, Dublin', 'HeBe001');
INSERT INTO Staff VALUES (0123462, 'Mark Walsh', '16/06/1976', 'The Square, Oldcastle, South Dublin', 'GaToy01');
INSERT INTO Staff VALUES (0123463, 'Dave Smith', '19/10/1987', '10 Hanover Qy., Tel, Clondalkin, Dublin', 'HoFur123');

INSERT INTO Equipment VALUES ('HPT001', 'Hand pallet truck', 'Manual', 0123456);
INSERT INTO Equipment VALUES ('SEPT001', 'Semi-electric pallet truck', 'Semi-electric', 0123462);
INSERT INTO Equipment VALUES ('EPT001', 'Electric pallet truck', 'Electric', 0123459);
INSERT INTO Equipment VALUES ('MS001', 'Manual stacker', 'Manual', 0123461);
INSERT INTO Equipment VALUES ('SES001', 'Semi-electric stacker', 'Semi-electric', 0123457);
INSERT INTO Equipment VALUES ('ES001', 'Electric stacker', 'Electric', 0123463);

INSERT INTO Supplier VALUES (123456780, 'Sony Store', 'Sony Headphones', 23456789, '13:30', '+353876543210');
INSERT INTO Supplier VALUES (123456791, 'Amazon', 'Amazon Echo Dot', 23456790, '12:30', '+353876543211');
INSERT INTO Supplier VALUES (123456802, 'Tommy Hilfiger', 'Tommy Hilfiger Backpack', 23456791, '11:00', '+353876543212');
INSERT INTO Supplier VALUES (123456813, 'Perfeclan', 'Wooden Hand Drum', 23456792, '15:30', '+353876543213');
INSERT INTO Supplier VALUES (123456824, 'Elgato Store', 'Elgato Stream Deck', 23456793, '17:00', '+353876543214');

INSERT INTO Product VALUES (00001111, 'Sony Headphones', 1000, '€219,000', 123456780);
INSERT INTO Product VALUES (00001112, 'Amazon Echo Dot', 1000, '€29,990', 123456791);
INSERT INTO Product VALUES (00001113, 'Tommy Hilfiger Backpack', 1000, '€64,540', 123456802);
INSERT INTO Product VALUES (00001114, 'Wooden Hand Drum', 500, '€11,545', 123456813);
INSERT INTO Product VALUES (00001115, 'Elgato Stream Deck', 500, '€104,995', 123456824);

INSERT INTO Product_Stock VALUES ('Elec0001', 00001111);
INSERT INTO Product_Stock VALUES ('Elec0002', 00001112);
INSERT INTO Product_Stock VALUES ('OutAcc0501', 00001113);
INSERT INTO Product_Stock VALUES ('MuscDJ0007', 00001114);
INSERT INTO Product_Stock VALUES ('HFHA0001', 00001115);

INSERT INTO Product_Delivery VALUES (23456789, 12345678);
INSERT INTO Product_Delivery VALUES (23456790, 12345679);
INSERT INTO Product_Delivery VALUES (23456791, 12345680);
INSERT INTO Product_Delivery VALUES (23456792, 12345681);
INSERT INTO Product_Delivery VALUES (23456793, 12345682);
 
UPDATE Staff SET Job_Id = 'MuscDJ0007' WHERE Staff_Id = 0123456;
UPDATE Shelf SET Capacity = 1000 WHERE Storage_Id = 'HoFur123';

SELECT * FROM Staff; 