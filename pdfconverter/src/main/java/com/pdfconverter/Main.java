package com.pdfconverter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import org.xhtmlrenderer.pdf.ITextRenderer;

public class Main {
    public static void main(String[] args) {
        // Obtiene el directorio donde se ejecuta el JAR
        String workingDir = System.getProperty("user.dir");
        // Ruta al archivo HTML dentro del mismo directorio
        String inputPath = workingDir + File.separator + "report.html";

        try {
            File htmlFile = new File(inputPath);
            if (!htmlFile.exists()) {
                System.err.println("El archivo report.html no se encontró en el directorio de trabajo: " + workingDir);
                return;
            }

            String url = htmlFile.toURI().toURL().toString();

            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocument(url);
            renderer.layout();

            // Ruta de salida del PDF
            String outputFile = workingDir + File.separator + "output.pdf";
            try (OutputStream os = new FileOutputStream(outputFile)) {
                renderer.createPDF(os);
            }

            System.out.println("PDF generado correctamente: " + outputFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
