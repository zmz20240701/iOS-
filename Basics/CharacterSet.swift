import Foundation
import SwiftUI


let alphnumeric = CharacterSet.alphanumerics
// alphnumeric 这个属性返回一个字符集
// 字符集包含了 Unicode 标准中 General Categories 为 L（字母）, M（符号）, N（数字）开头的所有字符
let string1 = "hello123"
let string2 = "hello 123!"
let string3 = "مرحبا123"

print(string1.unicodeScalars.allSatisfy { alphnumeric.contains($0)})
print(string2.unicodeScalars.allSatisfy { alphnumeric.contains($0)})
print(string3.unicodeScalars.allSatisfy { alphnumeric.contains($0)})
///true
//false
//true



let sentence = "Hello, world! How are you?"

let punctuationSet = CharacterSet.punctuationCharacters
let words = sentence.components(separatedBy: punctuationSet.union(.whitespaces))
print(words) //["Hello", "", "world", "", "How", "are", "you", ""]

let capitals = CharacterSet.uppercaseLetters
print(sentence.unicodeScalars.filter { capitals.contains($0) }) //HH


let sentence2 = "اَلْسَلاَمُ"
let symbols = CharacterSet.symbols
print(sentence2.unicodeScalars.filter({symbols.contains($0)}))







import Foundation

// NSRegularExpression 用于在字符串中查找与正则表达式模式匹配的部分。其核心功能是允许开发者使用一个 Block Iterator Method 来处理每一个匹配结果

// 目标字符串
let text = "Hello, World!, Hello, Swift!"

// 建立匹配项
let pattern = "(Hello), (\\w+)"
// 创建一个基于匹配项的正则表达式对象
let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)

// 1. Block Iterator Method
regex.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) { match, flags, stop in
    if let matchRange = match?.range { // rang 表示匹配项在原始字符串中的范围
        print("Found match at range: \(matchRange)")
        // Found match at range: {0, 5}
        // Found match at range: {15, 5}
    }
    
    if let firstGroupRange = match?.range(at: 1) {
        print("First group range: \(firstGroupRange)") // 第一个捕获组的范围
        let firstGroupText = (text as NSString).substring(with: firstGroupRange)
        print("First group text: \(firstGroupText)") // 第一个捕获组匹配的文本
        
        if let secondGroupRange = match?.range(at: 2) {
            print("Second group range: \(secondGroupRange)") // 第二个捕获组的范围
            let secondGroupText = (text as NSString).substring(with: secondGroupRange)
            print("Second group text: \(secondGroupText)") // 第二个捕获组匹配的文本
        }
    }
    // enumeratedMatches 方法枚举目标字符串中的所有匹配项
    // text.utf16.count 返回字符串的 UTF-16编码单元的数量，这是因为 NSRegularExpression 处理 NSRange 时基于 UTF-16编码
    // match 是一个 NSTextCheckingResult? 类型的可选值，表示匹配的结果
    // flags 是一个 NSRegularExpression.MatchingFlags 类型，表示匹配过程中的状态标志。
    // stop 是一个UnsafeMutablePointer<ObjCBool>类型的指针。指示是否停止后徐匹配。
    
    let numberOfMatches = regex.numberOfMatches(in: text, range: NSRange(location: 0, length: text.utf16.count))
    print(numberOfMatches) //2
    
    
    // NsTextCheckingResult 的属性（除了上边展示的 Range）
    regex.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) { match, flags, stop in
        if let resultType = match?.resultType { // rang 表示匹配项在原始字符串中的范围
            print("Found match at range: \(resultType)")
            // Found match at range: NSTextCheckingType(rawValue: 1024)
            // Found match at range: NSTextCheckingType(rawValue: 1024)
        }
    }
    
    // NsTextCheckingResult 的属性（除了上边展示的 Range）
    regex.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) { match, flags, stop in
        if let numberOfRanges = match?.numberOfRanges { // rang 表示匹配项在原始字符串中的范围
            print("Found match at range: \(numberOfRanges)")
            
        }
    }
}









import Foundation

import Foundation

// 目标字符串，包含链接和日期
let text = "Visit our website at https://www.example.com on 2024-08-29."

// 创建一个 NSDataDetector 实例，检测链接和日期
let detector = try NSDataDetector(
    types: NSTextCheckingResult.CheckingType.link.rawValue | NSTextCheckingResult.CheckingType.date.rawValue
)

// 使用 detector 查找目标字符串中的匹配项
let matches = detector.matches(in: text, range: NSRange(location: 0, length: text.utf16.count))


// 遍历所有的匹配结果
for match in matches {
    switch match.resultType {
    case .link:
        print("Found a link: \(match.url!)")
    case .date:
        print("Found a date: \(match.date!)")
    default:
        print("Nothing found")
    }
}

