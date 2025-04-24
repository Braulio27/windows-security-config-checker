package com.pdfconverter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import org.xhtmlrenderer.pdf.ITextRenderer;

public class Main {
    public static void main(String[] args) {

                // Ruta al archivo XHTML
        String inputPath = "/home/b_rodriguez@lan.municarrillo.go.cr/Scripts/Revisar equipo/report.xml";
        
        try {
            // Verifica si el archivo existe
            File htmlFile = new File(inputPath);
            if (!htmlFile.exists()) {
                System.err.println("El archivo " + inputPath + " no se encontró. Asegúrate de que exista en el directorio.");
                return;
            }

            // Convierte el archivo en una URL legible por Flying Saucer
            String url = htmlFile.toURI().toURL().toString();

            // Inicializa ITextRenderer
            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocument(url); // <-- Este método es el adecuado para cargar desde archivo
            renderer.layout();

            // Ruta de salida del PDF
            String outputFile = "output.pdf";
            try (OutputStream os = new FileOutputStream(outputFile)) {
                renderer.createPDF(os);
            }

            System.out.println("PDF generado correctamente desde archivo: " + outputFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}