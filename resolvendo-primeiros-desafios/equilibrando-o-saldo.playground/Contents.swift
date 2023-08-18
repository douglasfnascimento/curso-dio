var saldoAtual: Double = 0

func informarSaldoAtual(de valor: String) {
    saldoAtual = Double(valor) ?? 0
}

func depositar(valor: String) {
    saldoAtual += Double(valor) ?? 0
}

func retirar(valor: String) {
    saldoAtual -= Double(valor) ?? 0
}
print("Informe seu saldo atual:")
if let saldo = readLine() {
    informarSaldoAtual(de: saldo)
} else {
    print("Nenhum valor digitado.")
}

print("Informe o valor do depósito:")

if let deposito = readLine() {
    depositar(valor: deposito)
} else {
    print("Nenhum valor digitado.")
}

print("Informe o valor do saque:")

if let saque = readLine() {
    retirar(valor: saque)
} else {
    print("Nenhum valor digitado.")
}

print("Saldo atualizado na conta: \(saldoAtual)")
