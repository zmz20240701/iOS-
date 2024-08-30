import Foundation

// returns an array containing the results of mapping the given closure over the sequence's elements.


// flatMap 这种方法用于处理元素的转换结果是序列或集合的情况

enum HTTPResponse: CustomStringConvertible {
    case error(Int)
    case ok
    
    var description: String {
        switch self {
        case .error(let code):
            return "Error \(code)"
        case .ok:
            return "OK"
        }
    }
}


var responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(407), .error(600)]

responses.sort {
    switch ($0, $1) {
    case let (.error(aCode), .error(bCode)):
        return bCode < aCode
    case (.ok, .ok):
        return false
    case (.ok, .error):
        return true
    case (.error, .ok):
        return false
    }
}
print(responses)
