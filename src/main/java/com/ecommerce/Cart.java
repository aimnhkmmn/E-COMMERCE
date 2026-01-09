package com.ecommerce;

import java.util.ArrayList;
import java.util.List;

public class Cart {

    private final List<CartItem> items = new ArrayList<>();

    public void addProduct(Product product, String size) {
        if (product != null && size != null && !size.isEmpty()) {
            items.add(new CartItem(product, size));
        }
    }

    public void removeItem(int index) {
        if (index >= 0 && index < items.size()) {
            items.remove(index);
        }
    }

    public List<CartItem> getItems() {
        return items;
    }

    public int getItemCount() {
        return items.size();
    }

    public double getTotal() {
        double total = 0;
        for (CartItem item : items) {
            total += item.getProduct().getPrice();
        }
        return total;
    }
}