import Foundation

func realizarDeposito() {
    var saldo: Double = 0.0
    
    while true {
        if let input = readLine(), let valorDeposito = Double(input) {
            if valorDeposito == 0 {
                print("Encerrando o programa...")
                break
            } else if valorDeposito > 0 {
                saldo += valorDeposito
                let formatado = String(format: "%.2f", saldo)
                print("Depósito realizado com sucesso!\nSaldo atual: R$ \(formatado)")
            } else {
                print("Valor invalido! Digite um valor maior que zero.")
            }
        }
    }
}

realizarDeposito()
