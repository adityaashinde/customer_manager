# Customer CRUD Application

This is a Flutter-based CRUD (Create, Read, Update, Delete) application for managing customer information. The application uses the Provider package for state management and follows the MVC (Model-View-Controller) architectural pattern.

## Features

- Add, edit, and delete customer information
- Manage multiple addresses for each customer
- Validate PAN, email, and mobile number formats
- Prefill city and state fields based on postcode
- Store data locally using Provider state management

## Project Structure

lib/
├── controllers/
│ └── customer_controller.dart
├── models/
│ ├── customer.dart
│ └── address.dart
├── services/
│ └── api_service.dart
├── views/
│ ├── customer_form.dart
│ └── customer_list.dart
└── main.dart

- controllers/: Contains the business logic and state management.
- models/: Contains the data models for the application.
- services/: Contains the API service for network requests.
- views/: Contains the UI components.
- main.dart: Entry point of the application.

## Usage

1. Add a Customer:

Navigate to the "Add Customer" form.
Fill in the required details including PAN, Full Name, Email, Mobile Number, and Addresses.
Submit the form to add the customer to the list.

2. Edit a Customer:

On the customer list page, select the customer you want to edit.
Update the necessary details and submit the form to save changes.

3. Delete a Customer:

On the customer list page, select the customer you want to delete.
Confirm the deletion to remove the customer from the list.

### Contributing

- Fork the repository
- Create your feature branch (git checkout -b feature/your-feature)
- Commit your changes (git commit -m 'Add some feature')
- Push to the branch (git push origin feature/your-feature)
- Open a pull request

Feel free to customize this README file according to your specific project details.
