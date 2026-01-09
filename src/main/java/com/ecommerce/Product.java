package com.ecommerce; // Make sure this matches your actual package name

public class Product {
    // These names MUST match the "keys" in your products.json file exactly
    private final int id;
    private final String name;
    private final double price;
    private final String category;
    private final String type;
    private final String image;
    private final boolean isNew;
    private final boolean isSale;
    private final String brand;
    private final String description;

    // Constructor
    public Product(int id, String name, double price, String category, String type, String image, boolean isNew, boolean isSale, String brand, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.category = category;
        this.type = type;
        this.image = image;
        this.isNew = isNew;
        this.isSale = isSale;
        this.brand = brand;
        this.description = description;
    }

    // Getter methods (Required for JSP to read the data)
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getCategory() { return category; }
    public String getType() { return type; }
    public String getImage() { return image; }
    public boolean isNew() { return isNew; }
    public boolean isSale() { return isSale; }
    public String getBrand() { return brand;}
    public String getDescription() { return description; }
}
