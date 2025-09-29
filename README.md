# Spring Boot PostgreSQL CRUD

A CRUD project for testing methods of deploying a Spring Boot application with a PosgreSQL database.Test.

You can test the REST API using Postman:


GET all products:

URL: http://20.50.198.144/api/products

Response: A list of product DTOs.


GET product by ID:

URL: http://20.50.198.144/api/products/{id}

Response: The product data for the given ID.


POST create a new product:

URL: http://20.50.198.144/api/products

Body: { "name": "Laptop", "description": "A high-performance laptop.", "price": 1200.00 }


PUT update an existing product:

URL: http://20.50.198.144/api/products/{id}

Body: { "name": "Updated Laptop", "description": "An updated high-performance laptop.", "price": 1300.00 }


DELETE a product:

URL: http://20.50.198.144/api/products/{id}

Response: No content (HTTP 204).