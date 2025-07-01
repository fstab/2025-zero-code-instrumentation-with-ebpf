package com.example.planet_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

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
	String getPlanet() {
		return planets[random.nextInt(planets.length)] + "\n";
	}
}
