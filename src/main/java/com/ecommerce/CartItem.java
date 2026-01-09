package com.ecommerce;

public class CartItem {
    private final Product product;
    private final String size;

    public CartItem(Product product, String size) {
        this.product = product;
        this.size = size;
    }

    public Product getProduct() {
        return product;
    }

    public String getSize() {
        return size;
    }
}