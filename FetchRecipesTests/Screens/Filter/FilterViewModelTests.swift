//
//  FilterViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Richard Poutier on 2/17/25.
//

import XCTest
@testable import FetchRecipes

final class FilterViewModelTests: XCTestCase {

  var subject: FilterViewModel!
  // do not modify directly
  let cuisines = ["cuisine1", "cuisine2", "cuisine3", "cuisine4"]
  let filter = Filter(cuisines: ["cuisine1", "cuisine2"])
  
  func testWhenInitWithNoExistingFilterThenCorrectPropertiesAreSet() {
    // GIVEN
    let onApply: (Filter?) -> Void = { _ in }
    
    // WHEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: nil, onApply: onApply)
    
    // THEN
    XCTAssertEqual(subject.cuisines.count, cuisines.count)
    XCTAssertEqual(Set(subject.cuisines), Set(cuisines))
    XCTAssertTrue(subject.filteredCuisines.isEmpty)
  }
  
  func testWhenInitWithExistingFilterThenCorrectPropertiesAreSet() {
    // GIVEN
    let onApply: (Filter?) -> Void = { _ in }
    
    // WHEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: filter, onApply: onApply)
    
    // THEN
    XCTAssertEqual(subject.cuisines.count, cuisines.count)
    XCTAssertEqual(Set(subject.cuisines), Set(cuisines))
    XCTAssertEqual(subject.filteredCuisines, Set(filter.cuisines))
    XCTAssertEqual(subject.filteredCuisines.count, 2)
  }
  
  func testWhenToggleFilterIsCalledWithoutAnExistingFilterThenACuisineIsFiltered() {
    // GIVEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: nil, onApply: { _ in })
    
    // WHEN
    subject.toggleFiltered(cuisine: "cuisine1")
    
    // THEN
    XCTAssertTrue(subject.filteredCuisines.contains("cuisine1"))
    XCTAssertTrue(subject.filteredCuisines.count == 1)
  }
  
  func testWhenToggleFilterIsCalledWithoutAnExistingFilterThenACuisineIsRemovedFromTheFilters() {
    // GIVEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: nil, onApply: { _ in })
    
    // WHEN
    // call twice to simulate a cuisine already the `filteredCuisines`
    subject.toggleFiltered(cuisine: "cuisine1")
    subject.toggleFiltered(cuisine: "cuisine1")
    
    // THEN
    XCTAssertFalse(subject.filteredCuisines.contains("cuisine1"))
  }
  
  func testWhenToggleFilterIsCalledWithAnExistingFilterThenACuisineIsRemovedFromTheFilters() {
    // GIVEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: filter, onApply: { _ in })
    
    // WHEN
    subject.toggleFiltered(cuisine: "cuisine1")
    
    // THEN
    XCTAssertFalse(subject.filteredCuisines.contains("cuisine1"))
    XCTAssertTrue(subject.filteredCuisines.contains("cuisine2"))
  }
  
  func testWhenToggleFilterIsCalledWithAnExistingFilterThenACuisineIsFiltered() {
    // GIVEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: filter, onApply: { _ in })
    
    // WHEN
    subject.toggleFiltered(cuisine: "cuisine5")
    
    // THEN
    XCTAssertTrue(subject.filteredCuisines.contains("cuisine5"))
    XCTAssertTrue(subject.filteredCuisines.contains("cuisine1"))
    XCTAssertTrue(subject.filteredCuisines.contains("cuisine2"))
  }
  
  
  func testWhenClearAllFiltersIsCalledThenAllFiltersAreRemoved() { 
    // GIVEN
    subject = FilterViewModel(cuisines: cuisines, existingFilter: filter, onApply: { _ in })
    
    // WHEN
    XCTAssertFalse(subject.filteredCuisines.isEmpty)
    subject.clearAllFilters()
    
    // THEN
    XCTAssertTrue(subject.filteredCuisines.isEmpty)
  }
  
  func testWhenClearAllFiltersIsCalledThenOnApplyCallbackIsInvoked() {
    // GIVEN
    var onApplyCalled = false
    var appliedFilter: Filter? = nil
    let onApply: (Filter?) -> Void = { filter in
      appliedFilter = filter
      onApplyCalled = true
    }
    subject = FilterViewModel(cuisines: cuisines, existingFilter: filter, onApply: onApply)
    
    // WHEN
    XCTAssertFalse(subject.filteredCuisines.isEmpty)
    subject.clearAllFilters()
    
    // THEN
    XCTAssertTrue(onApplyCalled)
    XCTAssertNil(appliedFilter)
  }
  
  func testWhenApplyFilterIsCalledThenCallbackIsInvoked() {
    // GIVEN
    var onApplyCalled = false
    var appliedFilter: Filter? = nil
    let onApply: (Filter?) -> Void = { filter in
      appliedFilter = filter
      onApplyCalled = true
    }
    subject = FilterViewModel(cuisines: cuisines, existingFilter: nil, onApply: onApply)
    subject.toggleFiltered(cuisine: "cuisine1")
    
    // WHEN
    subject.applyFilter()
    
    // THEN
    XCTAssertTrue(onApplyCalled)
    XCTAssertEqual(appliedFilter, Filter(cuisines: ["cuisine1"]))
  }
}
