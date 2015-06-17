//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Prajna Kandarpa on 2015-06-17.
//  Copyright (c) 2015 Prajna Kandarpa. All rights reserved.
//

import Foundation

class CalculatorBrain {
    //swift can associate data with any enum
    // enum can implement protocols
    private enum Op: Printable
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        //add a description var so println can print something legible
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .UnaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
        
    }
    private var opStack = [Op]()
    
//    var knownOps = Dictionary<String, Op>()
    private var knownOps = [String:Op]()
    
    init() {
        
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
//        knownOps["×"] = Op.BinaryOperation("×") { $0*$1 }
        learnOp(Op.BinaryOperation("×", *))
//        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") { $1/$0 }
//        knownOps["+"] = Op.BinaryOperation("+") { $0+$1 }
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("×") { $1-$0 }
        knownOps["√"] = Op.UnaryOperation("√")  {  sqrt($0) }
    }
    
    //Arguments passed in become read-only in swift.
    // Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake.
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                    
                }
            }
            
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}