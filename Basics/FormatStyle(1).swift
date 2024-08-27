/**
Format: 格式化。在编程中，格式化是指将数据转换为特定格式的过程。比如把一个数字转换为货币格式，或者把一个日期转换为特定的字符串格式。

Style：风格，代表的就是特定格式。它决定了格式化后的数据应该是什么样子的。

合在一起就是：格式化风格，即将数据转换为特定格式的过程，并且这个格式是由风格决定的。Formate -> Style -> FormatStyle

在 Swift 中，FormatStyle 就一个负责格式化数据的样式或者风格的协议。它是一个泛型协议，可以用来格式化任何数据类型。

除了 Foundation 内置的格式化器（FormatStyle） 它们产出的结果为 String 和 AttributedString 类型的实例，我们还可以自定义 FormatStyle。自定义 FormatStyle 的方式就是实现 FormatStyle 协议。比如我们可以实现一个自定义的 FormatStyle，用来格式化日期。将数据格式化为 XML，JSON，或者其他格式。

格式化的过程会考虑本地化处理和单位的表示，不同地区的人们可能会使用不同的格式。比如在美国，人们习惯使用 MM/dd/yyyy 格式来表示日期，而在中国，人们习惯使用 yyyy-MM-dd 格式来表示日期。所以在格式化的时候，我们需要考虑到这些因素。


使用 FormateStyle 的方法有两个：

1.  创建一个符合 FormatStyle 协议的类型，然后使用 format(_:) 方法来格式化数据。这种方式适用于我们需要多次使用同一个 FormatStyle 来格式化多个数据的情况。
代码如下：
*/

import Foundation

let number1: Decimal = 123456.789
let number2: Decimal = 987654.321

//创建一个符合 FormatStyle 协议的类型
let customStyle: Decimal.FormatStyle = Decimal.FormatStyle().precision(.fractionLength(2))

//使用我们的自定义 FormatStyle 来格式化多个数值
let formattedNumber1: String = customStyle.format(number1)
let formattedNumber2: String = customStyle.format(number2)

print(formattedNumber1) // 123,456.79
print(formattedNumber2) // 987,654.32

/**
2.  支持格式化的数据类型有一个 formatted(_:) 方法，可以直接使用 FormatStyle 来格式化数据。这种方式适用于我们只需要一次性地格式化数据的情况。将想要的格式传递给 formatted(_:) 方法即可。
    除此之外，许多支持格式化的数据类型还提供了一个无参数的 formatted()方法。它会基于本地化的默认样式来进行格式化。

代码如下：
*/
let number3: Decimal = 123456.789

let formattedNumber3: String = number3.formatted(Decimal.FormatStyle().precision(.fractionLength(2)))

print(formattedNumber3) // 123,456.79

let number4: Decimal = 987654.321

let formattedNumber4 = number4.formatted()

print(formattedNumber4) // 987,654.321

//===================================================================================================

//修改初始化器
//在 Swift 中，我们可以通过修改初始化器来实现自定义的初始化逻辑。比如我们可以在初始化器中对属性进行赋值，或者对属性进行一些额外的处理。

//创建一个符合 FormatStyle 协议的类型实例。我们可以通过修改初始化器来实现自定义的初始化逻辑。
let style: IntegerFormatStyle<Int> = IntegerFormatStyle<Int>()
    .rounded(rule: .down, increment: 1000) //15250 -> 15000
    .locale(Locale(identifier: "en_US"))

let roundedNumber: String = style.format(15250)

print("roundedNumber: \(roundedNumber)") // 15,000
//===================================================================================================

//上边几个例子我们也看见了，没有直接使用 FormatStyle 协议，而是使用了 Decimal.FormatStyle 和 IntegerFormatStyle。这是因为 FormatStyle 是一个泛型协议，它需要一个具体的数据类型来进行格式化。所以我们需要使用 Decimal.FormatStyle 和 IntegerFormatStyle 这样的类型来实现 FormatStyle 协议。实现协议的类型都对协议进行了扩展（属性或方法）这些类型属性或方法都是在协议的基础上进行了预定义的扩展。比如 Decimal.FormatStyle 和 IntegerFormatStyle 都对 FormatStyle 协议进行了扩展，添加了一些属性和方法，用来格式化 Decimal 和 Int 类型的数据。在实际开发中我们可以直接使用这些便利化的类型，而不需要自己实现 FormatStyle 协议。

let formatted: IntegerFormatStyle<Int>.FormatOutput = 123456789.formatted(IntegerFormatStyle())
print("formatted: \(formatted)") // 123,456,789
//这个例子中 IntegerFormatStyle 是 FormatStyle 协议的一个实现，它对 Int 类型的数据进行了格式化。我们可以直接使用 IntegerFormatStyle 来格式化 Int 类型的数据。在这个例子中，我们使用 IntegerFormatStyle 来格式化一个 Int 类型的数据 123456789。最后输出的结果是 123,456,789。

//===================================================================================================

//调用 parse 方法来解析 formattedString
let formattedString: String = "$1,234.56"

//创建一个 parseStrategy
let parseStrategy: Decimal.ParseStrategy = Decimal.FormatStyle.Currency().parseStrategy
//我们可以通过其他的 FormatStyle 来获取不同的 parseStrategy。在这个例子中，我们使用 Decimal.FormatStyle.Currency() 来获取一个 parseStrategy。

let decimalValue = try? parseStrategy.parse(formattedString) //调用 parseStrategy 的 parse 方法来解析 formattedString

print("decimalValue: \(decimalValue)") // Optional(1234.56)



//使用初始化器来解析 formattedString
let formattedString2: String = "$1234.56"

let decimalValue2: Decimal? = try? Decimal(formattedString2, format: .currency(code: "USD"))

print("decimalValue2: \(decimalValue2)") // Optional(1234.56)





/*
Decimal.FormatStyle 是 swift 中用来格式化和解析 Decimal 类型数值的一个结构体。它提供了一些属性和方法，可以用来设置数值的格式化样式，比如小数位数、分组分隔符、小数点符号等等。Decimal.FormatStyle 是一个值类型，所以它的实例是不可变的，一旦创建就不能修改。

Decimal.FormatStyle 提供了两种嵌套类型，
1.  Decimal.FormatStyle.Percent 
2.  Decimal.FormatStyle.Currency

Decimal.FormatStyle.Percent 是用来格式化百分比数值的，它提供了一个属性 percentSymbol，用来设置百分比符号，默认是 %。Decimal.FormatStyle.Currency 是用来格式化货币数值的，它提供了一个属性 currencyCode，用来设置货币代码，默认是 USD。

*/
import Foundation

let exampleNumber: Decimal = 1234.5678

let customFormatting = exampleNumber.formatted(
    .number.precision(.fractionLength(2))
    .grouping(.never)
    .sign(strategy: .always())
)

print(customFormatting) // 1234.57
