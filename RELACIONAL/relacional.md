USER(**id**, sex, fname, lname, phone, email)

DRIVER(bank_account, **id**)
DRIVER(id) REFERENCES USUARIO(id)

RIDER(card_number, **id**)
RIDER(id) REFERENCES USUARIO(id)

RIDE(**id_driver**, **id_rider**, **ride_date**, rider_rating, driver_rating, vehicle_plate, price, duration, where_to, where_from)
RIDE(id_driver) REFERENCES DRIVER(id)
RIDE(id_rider) REFERENCES RIDER(id)

VEHICLE(vehicle_name, category, **plate**, owner_id)
VEHICLE(owner_id) REFERENCES DRIVER(id)

MAINTENCE(maintence_type, report, **maintence_date**, **vehicle_plate**)
MAINTENCE(vehicle_plate) REFERENCES VEHICLE(plate)

REPORT(report, **reported_id**, **reporter_id**)
REPORT(reported_id) REFERENCES USUARIO(id)
REPORT(reporter_id) REFERENCES USUARIO(id)
