package com.ecommerce; // Make sure this matches your actual package name

public class Product {
    // These names MUST match the "keys" in your products.json file exactly
    private int id;
    private String name;
    private double price;
    private String category;
    private String image;
    private boolean isNew;
    private boolean isSale;

    // Getter methods (Required for JSP to read the data)
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getCategory() { return category; }
    public String getImage() { return image; }
    public boolean isNew() { return isNew; }
    public boolean isSale() { return isSale; }
}