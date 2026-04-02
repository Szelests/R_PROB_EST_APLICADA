# Número de amigos
amigos <- 6

# Cálculo da Permutação (6!)
resultado <- factorial(amigos)

# Output formatado
cat("--- Problema de Permutação ---\n")
cat(sprintf("Total de amigos para a foto: %d\n", amigos))
cat(sprintf("Diferentes formas de sentar: %d\n", resultado))