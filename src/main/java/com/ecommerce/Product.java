package com.ecommerce; // Make sure this matches your actual package name

public class Product {
    // These names MUST match the "keys" in your products.json file exactly
    private int id;
    private String name;
    private double price;
    private String category;
    private String type;
    private String image;
    private boolean isNew;
    private boolean isSale;
    private String brand;

    // Constructor
    public Product(int id, String name, double price, String category, String type, String image, boolean isNew, boolean isSale, String brand) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.category = category;
        this.type = type;
        this.image = image;
        this.isNew = isNew;
        this.isSale = isSale;
        this.brand = brand;
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
}
