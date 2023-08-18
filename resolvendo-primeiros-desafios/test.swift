var saldoAtual: Double = 0

func informarSaldoAtual(de valor: Double) {
    saldoAtual = valor
}

func depositar(valor: Double) {
    saldoAtual += valor
}

func retirar(valor: Double) {
    saldoAtual -= valor
}

if let saldo = readLine() {
    informarSaldoAtual(de: saldo)
}

if let deposito = readLine() {
    depositar(valor: deposito)
}

if let saque = readLine() {
    retirar(valor: saque)
}

print("Saldo atualizado na conta: \(saldoAtual)")
