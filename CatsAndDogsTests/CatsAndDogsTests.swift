import XCTest
@testable import CatsBreeds

final class CatsAndDogsTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllBreeds() async throws {
        let allBreeds = await CatsBreedsParser.getAllCatsInfo()
        
        XCTAssertNotNil(allBreeds)
    }
    
    func testGetImageURL() async throws {
        let allBreeds = await CatsBreedsParser.getAllCatsInfo()
        
        let imageURL = try await allBreeds.get().first?.getImage()
        print(imageURL)
        
        XCTAssertNotNil(allBreeds)
    }
}
