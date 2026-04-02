# Variáveis
n_math <- 6; k_math <- 4
n_phys <- 7; k_phys <- 2

# Cálculos
comb_math <- choose(n_math, k_math)
comb_phys <- choose(n_phys, k_phys)
total <- comb_math * comb_phys

# Output formatado
cat("--- Relatório de Probabilidade ---\n")
cat(sprintf("Combinações de Matemática: %d\n", comb_math))
cat(sprintf("Combinações de Física: %d\n", comb_phys))
cat("----------------------------------\n")
cat(paste("Total de opções diferentes:", total, "\n"))