package com.example.planet_service;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Enumeration;
import java.util.Random;

@SpringBootApplication
@RestController
public class PlanetServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PlanetServiceApplication.class, args);
	}

	private final Random random = new Random(0);

	private final String[] planets = new String[]{
			"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"
	};

	@GetMapping(value = "/planet", produces = MediaType.TEXT_PLAIN_VALUE)
	String getPlanet(HttpServletRequest request) {
		dumpIncomingHeaders(request);
		return planets[random.nextInt(planets.length)] + "\n";
	}

	// this isn't thread save, lines from different requests might be mixed up on stdout
	private void dumpIncomingHeaders(HttpServletRequest request) {
		System.out.println("Received a request with the following headers:");
		Enumeration<String> headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String headerName = headerNames.nextElement();
			String headerValue = request.getHeader(headerName);
			System.out.println("  " + headerName + ": " + headerValue);
		}
		System.out.println();
	}
}
