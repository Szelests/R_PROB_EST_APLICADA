# Dados do problema
n_cadeiras <- 6
n_pessoas <- 4

# Cálculo do Arranjo (A = n! / (n-k)!)
resultado <- factorial(n_cadeiras) / factorial(n_cadeiras - n_pessoas)

# Outra forma: Combinação * Permutação
# resultado <- choose(6, 4) * factorial(4)

cat("--- Cinema: Problema de Arranjo ---\n")
cat(sprintf("Cadeiras disponíveis: %d\n", n_cadeiras))
cat(sprintf("Pessoas: %d\n", n_pessoas))
cat("-----------------------------------\n")
cat(sprintf("Maneiras diferentes de sentar: %d\n", resultado))