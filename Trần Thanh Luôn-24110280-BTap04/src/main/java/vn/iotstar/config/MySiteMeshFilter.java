package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

import jakarta.servlet.annotation.WebFilter;

@WebFilter("/*")
public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Assigning decorators to different paths
        builder.addDecoratorPath("/admin/*", "/admin.jsp")
               .addDecoratorPath("/*", "/web.jsp")
               
               // Exclude paths from decoration
               .addExcludedPath("/assets/*")
               .addExcludedPath("/uploads/*")
               .addExcludedPath("/api/*");
    }
}
