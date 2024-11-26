import Foundation

public extension Encodable {
    func asJson() -> Result<String, Error>{
        JSONEncoder()
            .try(self)
            .flatMap{ $0.asString() }
    }
}

public extension String {
    func decodeFromJson<T>(type: T.Type) -> Result<T, Error> where T: Decodable {
        self.asData()
            .flatMap { JSONDecoder().try(type, from: $0) }
    }
}

///////////////////////////////
/// HELPERS
//////////////////////////////

fileprivate extension JSONEncoder {
    func `try`<T : Encodable>(_ value: T) -> Result<Output, Error> {
        do {
            return .success(try self.encode(value))
        } catch {
            return .failure(error)
        }
    }
}

fileprivate extension JSONDecoder {
    func `try`<T: Decodable>(_ t: T.Type, from data: Data) -> Result<T,Error> {
        do {
            return .success(try self.decode(t, from: data))
        } catch {
            return .failure(error)
        }
    }
}

fileprivate extension String {
    func asData() -> Result<Data, Error> {
        if let data = self.data(using: .utf8) {
            return .success(data)
        } else {
            return .failure(WTF("can't convert string to data: \(self)"))
        }
    }
}

fileprivate extension Data {
    func asString() -> Result<String, Error> {
        if let str = String(data: self, encoding: .utf8) {
            return .success(str)
        } else {
            return .failure(WTF("can't convert Data to string"))
        }
    }
}

fileprivate func WTF(_ msg: String, code: Int = 0) -> Error {
    NSError(code: code, message: msg)
}

internal extension NSError {
    convenience init(code: Int, message: String) {
        let userInfo: [String: String] = [NSLocalizedDescriptionKey:message]
        self.init(domain: "FTW", code: code, userInfo: userInfo)
    }
}
