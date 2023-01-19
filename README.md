# Introduction
EnDine is a database booking system which allows their passengers from MokéCruise to order cabin service, reserve seats in restaurants and dining halls as well as book activities and entertainment on board any of their cruise ships.

# Mapped Relation
EventType(ETID, ETName)

Event(EventID, EventName, EventDescr, EventLoc, MinAge, MaxAge, EventCapacity, EventDuration, AdultPrice,  ChildPrice, [ETID])

EventSession([EventID], SessionNo, EventDateTime)

Booking(BookingID, NoOfAdultTicket, NoOfChildTicket, AdultSalesPrice, ChildSalesPrice, BookStatus, BookDateTime, <PgrID>, <EventID, SessionNo>)

Passenger(PgrID, PgrName, PgrEmail, PgrDOB, PgrGender, CabinNo)

PgrContactNo(PgrContactNo, PgrID)

Reservation(ReservID, ReservStatus, RequiredDateTime, ReservDateTime, NoOfPax, [PgrID], [EatyID])

Eatery(EatyID, EatyClHr, EatyOpHr, EatyCapacity, EatyLoc, EatyName)

Dish(DishID, DishName, DishDescr, [cuisineID], [EatyID])

categorised_in([DishID], [FcID])

contain([DishID],[IngredID])

FoodCategory(FcID, FcDescr, FcName)

Cuisine(cuisineID, cuisineName)
Ingredient(IngredID, IngredName)

CSDish([DishID], Price)

orders([DishID], [PgrID], OrderPrice, OrderQty, OrderDateTime, DeliverTo, DelDateTime)
