//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Faruk on 7.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {

    var viewModel: MoviesViewModel!
    var service: MovieService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = MovieService()
        viewModel = MoviesViewModel(service: service)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //fatal error
    func testFetchWithNoService() {

        // giving no service to a view model
        service = nil
        // expected to not be able to fetch currencies
        viewModel.fetchMovies()
        service.fetchMovies(pageId: "1") { (response, error) in
            
        }
    }
    
    //invalid page number check
    func testDataSource(){
        viewModel.pageId = -1
        viewModel.fetchMovies()
        XCTAssertGreaterThanOrEqual(viewModel.dataSource.count, 1)
    }

}
