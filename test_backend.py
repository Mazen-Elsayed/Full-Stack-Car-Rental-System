from datetime import datetime, timedelta
from Final_Project.backend import Admin, Customer
import mysql.connector

def setup_test_database():
    try:
        # Connect directly to create initial data
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="car_rental"
        )
        cursor = db.cursor()
        
        # Add test office
        cursor.execute("""
            INSERT INTO offices (country, phone) 
            VALUES ('Test Country', '123-456-7890')
            ON DUPLICATE KEY UPDATE country=country
        """)
        
        db.commit()
        office_id = cursor.lastrowid
        cursor.close()
        db.close()
        
        return office_id
    except Exception as e:
        print(f"Error setting up test data: {e}")
        return None

def test_admin_operations(office_id):
    admin = Admin()
    
    # Test car registration with valid office_id
    result = admin.register_car(
        plate_id="ABC123",
        model="Toyota Camry",
        year=2023,
        office_id=office_id,  # Use the created office_id
        price_per_day=100.00
    )
    print(f"Register car result: {result}")
    
    # Test getting statistics
    stats = admin.get_car_statistics()
    print(f"Car statistics: {stats}")

def test_customer_operations():
    customer = Customer()
    
    # Test customer registration
    result = customer.register_customer(
        fname="John",
        lname="Doe",
        email="john@example.com",
        password="password123",
        phone="1234567890"
    )
    print(f"Register customer result: {result}")
    
    # Test car search
    cars = customer.search_available_cars(
        max_price=150.00,
        year=2023
    )
    print(f"Available cars: {cars}")
    
    # Test reservation creation
    if cars:
        result = customer.create_reservation(
            customer_ssn=1,  # Assuming this is the SSN from registration
            plate_id=cars[0]['plate_id'],
            pickup_date=datetime.now() + timedelta(days=1),
            return_date=datetime.now() + timedelta(days=3)
        )
        print(f"Create reservation result: {result}")

def test_reports():
    system = Admin()  # Using Admin since it has all base class methods
    
    # Test reservation report
    start_date = datetime.now() - timedelta(days=30)
    end_date = datetime.now() + timedelta(days=30)
    
    reservations = system.get_reservations_report(start_date, end_date)
    print(f"Reservations report: {reservations}")
    
    # Test car status
    status = system.get_cars_status_on_date(datetime.now())
    print(f"Current car status: {status}")
    
    # Test payment report
    payments = system.get_daily_payments(start_date, end_date)
    print(f"Payment report: {payments}")

if __name__ == "__main__":
    try:
        office_id = setup_test_database()
        if office_id:
            print(f"Created test office with ID: {office_id}")
            
            print("Testing Admin Operations...")
            test_admin_operations(office_id)
            
            print("\nTesting Customer Operations...")
            test_customer_operations()
            
            print("\nTesting Reports...")
            test_reports()
        
    except Exception as e:
        print(f"Test failed with error: {e}")
