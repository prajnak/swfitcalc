# Notes about Swift
======================
## Constants and Variable
### Declaration
#### Constants 
> let maximumNumberOfLoginAttempts = 10

#### Variables 
> var currentLoginAttempt = 0

#### Type Annotations
Type annotations can be provided during variable or constant declaration. Place a colon after the constant or variable name, followed by a space and the name of the type to use. 
> var red, green, blue: Double

Constant or variable names can contain almost any character, including Unicode characters. They can't contain whitespace characters, mathematical symbols, arrows. They can't begin with a number. After declaration, the variable or constant can;t be redeclared, netiher can its type be changed. Const -> Variable and Var->const conversion isn't possible.

Constants or variables that need to be named something that is a Swift keyword maybe done so if they are surrounded by back ticks(`).

#### Printing consts and vars
```
var friendlyWelcome = "Bonjour!"
println("Hello, and \(friendlyWelcome)") 
