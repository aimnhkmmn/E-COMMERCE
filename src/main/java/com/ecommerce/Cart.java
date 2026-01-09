package com.ecommerce;

import java.util.ArrayList;
import java.util.List;

public class Cart {

    private final List<Product> items = new ArrayList<>();

    public void addProduct(Product product) {
        if (product != null) {
            items.add(product);
        }
    }

    public void removeProduct(int index) {
        if (index >= 0 && index < items.size()) {
            items.remove(index);
        }
    }

    public List<Product> getItems() {
        return items;
    }

    public int getItemCount() {
        return items.size();
    }

    public double getTotal() {
        double total = 0;
        for (Product item : items) {
            total += item.getPrice();
        }
        return total;
    }
}