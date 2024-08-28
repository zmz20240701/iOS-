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


//URLResourceKey 是一个结构体,它包含了一组静态常量,这些常量用于表示 URL 资源的各种属性,通过这些属性键,可以获取和设置文件或目录的各种元数据.

import Foundation

// 创建 URL 组件
let webURL: URL? = URL(string: "URL: https://www.example.com/search?query=swift&page=1")

// 获取 URL 的各个部分
print("Scheme: \(webURL?.scheme ?? "nil")")
print("Host: \(webURL?.host ?? "nil")")
print("Path: \(webURL?.path ?? "nil")")
print("Query: \(webURL?.query ?? "nil")")
print("Fragment: \(webURL?.fragment ?? "nil")")
print("Port: \(webURL?.port ?? 0)")

//如何获取 queryItems
let urlComponents = URLComponents(string: "https://www.example.com/search?query=swift&page=1")
let queryItems = urlComponents?.queryItems
print("queryItems: \(queryItems ?? [])")
for queryItem in queryItems ?? [] {
    print("name: \(queryItem.name), value: \(queryItem.value ?? "")")
}

