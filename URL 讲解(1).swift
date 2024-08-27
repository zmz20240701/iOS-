import Foundation
/*
URL.Strategy 的主要作用是在解析 URL 字符串时，根据 URL 的不同部分，将其解析成不同的类型，比如 URL 的 scheme 部分解析成 URL.Scheme 类型，host 部分解析成 URL.Host 类型等等。这样做的好处是，我们可以在不同的类型中定义不同的方法，以便于我们更好地处理 URL 的不同部分。
*/


let fileURL = URL(fileURLWithPath: "/Users/ken/Desktop/file1.txt")
print(fileURL) //file:///Users/ken/Desktop/file1.txt
print(type(of: fileURL)) // URL


let urlString = fileURL.absoluteString
print(urlString) //file:///Users/ken/Desktop/file1.txt
print(type(of: urlString)) //String


let url = URL(string: urlString)
print(url!)
