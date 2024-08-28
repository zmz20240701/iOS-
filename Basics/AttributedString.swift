import Foundation
import SwiftUI

// NSAttributedString 

// 1. AttributeString 是 SwiftUI 的一个 View，而 NSAttributedString 是 UIKit 的一个类
// 2. AttributeString 是一个 View，可以直接在 SwiftUI 中使用，而 NSAttributedString 需要通过 UIRepresentable 封装后才能在 SwiftUI 中使用


// NSAttributedString管理字符串中的单个字符或一个段落，以及相关联的一组属性。这些属性包括字体、段落样式、颜色、链接、文本特效、文本附件和其他特定于文本的属性。NSAttributedString对象是不可变的，这意味着一旦创建了NSAttributedString对象，就不能更改其内容或属性。如果需要更改字符串或属性，请使用NSMutableAttributedString类

// Attribute String(富文本字符串) 通过属性名来识别属性值，这种关系通过 NSDictionary 对象来存储。具体来说，属性名对应的是 NSAttributedString.Key 类型的常量，属性值对应的是 Any 类型的值。
// 开发者可以自定义属性来满足特定的需求。还可以将任何属性应用到任何范围的文本中，而不仅仅是整个字符串。这使得富文本字符串非常灵活，可以满足各种需求。


// AttributeStringKey 是一个协议，它定义了一个属性，用于标识属性字符串的键。这个键是一个字符串，它用于标识属性字符串中的属性。这个键可以是标准键，也可以是自定义键。


enum OutlineColorAttribute : AttributedStringKey {
    typealias Value = Color
    
    static var name = "OutlineColor" 
} 

//调用者可以使用这个类型来获取富文本中的属性值。但是通常你会通过 name 属性来获取属性值。

// 创建一个或者多个符合 AttributeScope 的结构体，其中为属性提供映射到 符合 AttributeStirngKey 协议的实例（这里就是 OutlineColorAttribute）的短名称。 比如下面的代码：

// 创建了一个结构体 MyTextStytleAttributes，它包含了一个属性 outlineColor，它的类型是 OutlineColorAttribute。这个结构体遵循了 AttributeScope 协议，这个协议要求提供一个属性字典，这个字典的键是字符串，值是 Any 类型。这个结构体的作用是将 OutlineColorAttribute 映射到 outlineColor 属性上。
struct MyTextStytleAttributes : AttributeScope {
    let outlineColor : OutlineColorAttribute // OutlineColorAttribute.Value == Color
}

let outlineColor = attributes[OutlineColorAttribute.name] as? Color

// 你可以通过下面的代码来设置属性值：

attributes[OutlineColorAttribute.name] = Color.red

// 你可以通过下面的代码来删除属性值：

attributes.removeValue(forKey: OutlineColorAttribute.name)

// 你可以通过下面的代码来检查属性值是否存在：

if attributes[OutlineColorAttribute.name] != nil {
    // 属性值存在
} else {
    // 属性值不存在
}

// 你可以通过下面的代码来获取属性值的类型：

let type = OutlineColorAttribute.Value.self

// 你可以通过下面的代码来获取属性键的名称：

let name = OutlineColorAttribute.name

// 你可以通过下面的代码来获取属性键的哈希值：

let hashValue = OutlineColorAttribute.hashValue

// 你可以通过下面的代码来获取属性键的描述：

let description = OutlineColorAttribute.description

// 你可以通过下面的代码来获取属性键的调试描述：

let debugDescription = OutlineColorAttribute.debugDescription

// 你可以通过下面的代码来获取属性键的自定义调试描述：

let customMirror = OutlineColorAttribute.customMirror


// 在扩展完 AttributeScope 以后你需要扩展 AttributeDynamicLookUp 来允许调用者使用动态成员查找语法。比如
AttributeString.outlineColor = .red

// 框架或库会使用 AttributeStringKey 类型来定义属性。为了使得可以用动态成员查找法来访问属性，框架或库会创建一个或多个符合 AttributeScope 的结构体，其中为属性提供映射到 符合 AttributeStirngKey 协议的实例的短名称。

struct TextStyleAttributes : AttributeScope {
    let foregroundColor : ForegroundColorAttribute // ForegroundColorAttribute.Value == Color
    let forebackgroundColor : BackgroundColorAttribute // BackgroundColorAttribute.Value == Color
    let underlineColor : UnderlineStyleAttribute // UnderlineStyleAttribute.Value == UnderlineStyle
     
}
