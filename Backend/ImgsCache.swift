import Foundation
import SwiftUI

class ImgsCache {
    static let shared = ImgsCache()
    
    private init(){ }
    
    private let internalQueue = DispatchQueue(label: "com.singletioninternal.queue", qos: .default, attributes: .concurrent)
    
    private var dict: [String: UIImage] = [:]
    
    func getImg(id: String) -> UIImage? {
        return internalQueue.sync {
            dict[id]
        }
    }
    
    func saveImg(id: String, img: UIImage) {
        internalQueue.async(flags: .barrier) {
            self.dict[id] = img
        }
    }
}
