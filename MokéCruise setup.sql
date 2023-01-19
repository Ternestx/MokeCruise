CREATE DATABASE MokéCruise

DROP TABLE contain
DROP TABLE categorised_in
DROP TABLE Booking
DROP TABLE EventSession
DROP TABLE Event
DROP TABLE EventType
DROP TABLE Reservation
DROP TABLE orders
DROP TABLE CSDish
DROP TABLE Dish
DROP TABLE Ingredient
DROP TABLE Cuisine
DROP TABLE FoodCategory
DROP TABLE Eatery
DROP TABLE PgrContactNo
DROP TABLE Passenger

CREATE TABLE Passenger
(
PgrID char(5) not null,
PgrName varchar(30) not null,
PgrEmail varchar(50) null,
PgrDOB Date not null,
PgrGender varchar(6) null,
CabinNo char(5) not null,
Constraint PK_Passenger_PgrID PRIMARY KEY(PgrID),
Constraint ck_PgrGender CHECK (PgrGender in ('Male', 'Female'))
)

CREATE TABLE PgrContactNo
(
PgrID char(5) not null,
PgrContactNo varchar(20) not null,
Constraint PK_PgrContactNo_PgrID Primary Key(PgrID, PgrContactNo),
Constraint FK_PgrContactNo_PgrID FOREIGN KEY(PgrID) REFERENCES Passenger(PgrID)
)

CREATE TABLE Eatery
(
EatyID char(5) not null,
EatyClHr Time null,
EatyOpHr Time null,
EatyCapacity varchar(5) null,
EatyLoc varchar(30) not null,
EatyName varchar(30) not null,
Constraint PK_Eatery_EatyID PRIMARY KEY(EatyID)
)

CREATE TABLE FoodCategory
(
FcID char(5) not null,
FcDescr varchar(100) not null,
FcName varchar(30) not null,
Constraint PK_FoodCategory_FcID Primary Key(FcID)
)

CREATE TABLE Cuisine
(
cuisineID char(5) not null,
cuisineName varchar(30) not null,
Constraint PK_Cuisine_cuisineID Primary Key(cuisineID)
)

CREATE TABLE Ingredient
(
IngredID char(5) not null,
IngredName varchar(30) not null,
Constraint PK_Ingredient_IngredID Primary Key(IngredID)
)

CREATE TABLE Dish
(
DishID char(5) not null,
DishName varchar(30) not null,
DishDescr varchar(100) not null,
cuisineID char(5) not null,
EatyID char(5) null,
Constraint PK_Dish_DishID Primary Key(DishID),
CONSTRAINT FK_Dish_cuisineID FOREIGN KEY(cuisineID) REFERENCES Cuisine(cuisineID),
CONSTRAINT FK_Dish_EatyID FOREIGN KEY(EatyID) REFERENCES Eatery(EatyID)
)

CREATE TABLE CSDish
(
DishID char(5) not null,
Price Decimal(10,2) null,
Constraint PK_CSDish_DishID Primary Key(DishID),
Constraint FK_CSDish_DishID FOREIGN KEY(DishID) REFERENCES Dish(DishID)
)

CREATE TABLE orders
(
DishID char(5) not null,
PgrID char(5) not null,
OrderPrice Decimal(10,2) null,
OrderQty varchar(3) not null,
OrderDateTime DateTime not null,
DeliverTo varchar(30) not null,
DelDateTime DateTime null,
Constraint PK_orders_DishID Primary Key(DishID, PgrID, OrderDateTime),
Constraint FK_orders_DishID FOREIGN KEY(DishID) REFERENCES Dish(DishID),
Constraint FK_orders_PgrID FOREIGN KEY(PgrID) REFERENCES Passenger(PgrID)
)

CREATE TABLE EventType
(
ETID char(5) not null,
ETName varchar(30) not null,
Constraint PK_EventType_ETID Primary Key(ETID)
)

CREATE TABLE Event
(
EventID char(5) not null,
EventName varchar(30) not null,
EventDescr varchar(100) null,
EventLoc varchar(30) not null,
MinAge varchar(3) null,
MaxAge varchar(3) null,
EventCapacity varchar(5) not null,
EventDuration int null,
AdultPrice Decimal(10,2) null,
ChildPrice Decimal(10,2) null,
ETID char(5) not null,
Constraint PK_Event_EventID Primary Key(EventID),
Constraint FK_Event_ETID FOREIGN KEY(ETID) REFERENCES EventType(ETID)
)

CREATE TABLE EventSession
(
SessionNo char(5) not null,
EventID char(5) not null,
EventDateTime DateTime not null,
Constraint PK_EventSession_SessionNo Primary Key(SessionNo, EventID),
Constraint FK_EventSession_EventID FOREIGN KEY(EventID) REFERENCES Event(EventID)
)

CREATE TABLE Booking
(
BookingID char(5) not null,
NoOfAdultTicket varchar(5) null,
NoOfChildTicket varchar(5) null,
AdultSalesPrice Decimal(10,2) null,
ChildSalesPrice Decimal(10,2) null,
BookStatus varchar(15) not null,
BookDateTime DateTime not null,
PgrID char(5) not null,
EventID char(5) not null,
SessionNo char(5) not null,
Constraint PK_Booking_BookingID Primary Key(BookingID),
Constraint FK_Booking_PgrID FOREIGN KEY(PgrID) REFERENCES Passenger(PgrID),
Constraint FK_Booking_EventID FOREIGN KEY(EventID) REFERENCES Event(EventID),
Constraint FK_Booking_SessionNo FOREIGN KEY(SessionNo, EventID) REFERENCES EventSession(SessionNo, EventID)
)

CREATE TABLE Reservation
(
ReservID char(5) not null,
ReservStatus varchar(10) not null,
RequiredDateTime DateTime not null,
ReservDateTime DateTime not null,
NoOfPax varchar(5) not null,
PgrID char(5) not null,
EatyID char(5) not null,
Constraint PK_Reservation_ReservID Primary Key(ReservID),
Constraint FK_Reservation_PgrID FOREIGN KEY(PgrID) REFERENCES Passenger(PgrID),
Constraint FK_Reservation_EatyID FOREIGN KEY(EatyID) REFERENCES Eatery(EatyID),
Constraint CHK_Reservation check (RequiredDateTime > ReservDateTime and DATEDIFF(Minute, ReservDateTime, RequiredDateTime) <= 1440)
)

CREATE TABLE categorised_in
(
DishID char(5) not null,
FcID char(5) not null,
Constraint PK_categorised_in_DishID Primary Key(DishID, FcID),
Constraint FK_categorised_in_DishID FOREIGN KEY(DishID) REFERENCES Dish(DishID),
Constraint FK_categorised_in_FcID FOREIGN KEY(FcID) REFERENCES FoodCategory(FcID)
)

CREATE TABLE contain
(
DishID char(5) not null,
IngredID char(5) not null,
Constraint PK_contain_DishID Primary Key(DishID, IngredID),
Constraint FK_contain_DishID FOREIGN KEY(DishID) REFERENCES Dish(DishID),
Constraint FK_contain_IngredID FOREIGN KEY(IngredID) REFERENCES Ingredient(IngredID)
)

