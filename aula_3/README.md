# 📊 Exercícios de Probabilidade e Estatística - R

Este repositório contém a resolução de exercícios de contagem (Combinatória) utilizando a linguagem **R**, focando na diferença entre Combinação, Arranjo e Permutação.

---

## 1. Exercício de Combinação (Escolha de Questões)
**Enunciado:** Uma prova consta de 6 questões de Matemática e 7 de Física. O aluno deve escolher 4 de Matemática e 2 de Física. Quantas opções de escolha ele tem?

### 💡 Lógica
Como a ordem das questões escolhidas não altera o conjunto, utilizamos **Combinação**.
O resultado total é o produto das combinações: $C(6,4) \times C(7,2)$.

```r
# Cálculo no R
total_math <- choose(6, 4)
total_phys <- choose(7, 2)
resultado_1 <- total_math * total_phys

cat("Total de opções de prova:", resultado_1)
# Saída: 315

---

# Cálculo no R
n <- 6
k <- 4
resultado_2 <- factorial(n) / factorial(n - k)

cat("Maneiras de sentar no cinema:", resultado_2)
# Saída: 360

---

# Cálculo no R
amigos <- 6
resultado_3 <- factorial(amigos)

cat("Formas de organizar a foto:", resultado_3)
# Saída: 720