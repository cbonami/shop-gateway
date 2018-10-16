package be.vdab.demo.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;

//@Configuration
@SpringBootApplication
public class GatewayApplication {


    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }

    // http://www.codeblogbt.com/archives/302364
    @Bean
    public RouteLocator routeLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                .route("host_route", r ->
                        r.path("/shopfront/**")
                                .filters(
                                        f -> f.stripPrefix(1)
                                )
                                .uri("http://shopfront:8082")
                )
                .route("host_route", r ->
                        r.path("/productcatalogue/**")
                                .filters(
                                        f -> f.stripPrefix(1)
                                )
                                .uri("http://productcatalogue:8083")
                )
                .route("host_route", r ->
                        r.path("/stockmanager/**")
                                .filters(
                                        f -> f.stripPrefix(1)
                                )
                                .uri("http://stockmanager:8081")
                )
                .build();
    }

}
