package com.ce.fisa.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class ProcessController {
	
	@GetMapping("/test")
	public String reqRes() {
		log.info("요청 수락 ~~~");
		return "linux 서버에서 실행되는 app";
	}
	@GetMapping("/test2")
	public String reqRes2() {
		log.info("요청 수락2 ~~~");
		return "linux 서버에서 실행되는 app2";
	}
	@GetMapping("/test23")
	public String reqRes23() {
		log.info("요청 수락233 ~~~");
		return "linux 서버에서 실행되는 app23";
	}
}
