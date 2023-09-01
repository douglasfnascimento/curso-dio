import Foundation

func main() {
    repeat {
        if let input = readLine(), {
            if input > 0 {
                let valor = Double(input)
                print("Depósito realizado com sucesso!\nSaldo atual: R$ \(valor)")
            } else if valor == 0 {
                print("Encerrando o programa...")
                break
            } else {
                //TODO: Imprimir a mensagem de encerrar o programa.
            }
        } while input < 0
    }
}

main()
