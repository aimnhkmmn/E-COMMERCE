package com.ecommerce;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.FileReader;
import java.io.Reader;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class ProductLoader {

    // This method takes the file path and returns a List of Product objects
    public static List<Product> loadProducts(String filePath) {
        List<Product> productList = new ArrayList<>();

        try (Reader reader = new FileReader(filePath)) {
            Gson gson = new Gson();

            // This weird line tells Gson: "Expect a List of Product objects, not just one"
            Type listType = new TypeToken<ArrayList<Product>>(){}.getType();

            // Convert JSON text -> Java List
            productList = gson.fromJson(reader, listType);

        } catch (Exception e) {
            System.err.println("Error loading products from " + filePath + ": " + e.getMessage());
        }

        return productList;
    }
}