# ==============================================================================
# TRABALHO APLICADO: ENGENHARIA ELETRÔNICA - ESTATÍSTICA DESCRITIVA
# Circuito Regulador de Tensão (Valor Ideal: 5.0 V)
# ==============================================================================

# Base de Dados (em volts)
tensao <- c(4.8, 4.9, 5.0, 5.1, 5.0, 4.7, 4.6, 5.2, 5.3, 4.9,
            5.0, 5.1, 5.2, 5.4, 5.5, 4.5, 4.4, 4.8, 4.9, 5.0,
            5.1, 5.2, 5.3, 5.6, 5.8, 4.3, 4.2, 4.7, 4.8, 4.9,
            5.0, 5.1, 5.2, 5.3, 6.0, 6.2, 3.8, 4.0, 4.5, 4.7)

# Função auxiliar para Moda
get_moda <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# ==============================================================================
# PARTE 1: ORGANIZAÇÃO DOS DADOS
# ==============================================================================
cat("\n==================== PARTE 1: ORGANIZAÇÃO DOS DADOS ====================\n")

# 1) Rol ordenado
cat("\n[1] ROL ORDENADO (Medições em ordem crescente):\n")
cat(sort(tensao), sep = " | ")
cat("\n")

# 2 e 3) Tabela de frequências
freq_simples <- table(tensao)
freq_acumulada <- cumsum(freq_simples)

tabela_frequencia <- data.frame(
  Tensao_V = names(freq_simples),
  F_Absoluta = as.vector(freq_simples),
  F_Acumulada = as.vector(freq_acumulada)
)
cat("\n[2/3] TABELA DE FREQUÊNCIAS:\n")
print(tabela_frequencia, row.names = FALSE)

# 4) Agrupamento em classes (Regra de Sturges)
n <- length(tensao)
k <- round(1 + 3.322 * log10(n)) 
classes <- cut(tensao, breaks = k)
cat("\n[4] DISTRIBUIÇÃO POR CLASSES (Justificativa: Regra de Sturges, k =", k, "):\n")
print(table(classes))


# ==============================================================================
# PARTE 2: MEDIDAS DE LOCALIZAÇÃO (TENDÊNCIA CENTRAL)
# ==============================================================================
cat("\n==================== PARTE 2: MEDIDAS DE LOCALIZAÇÃO ===================\n")

media <- mean(tensao)
mediana <- median(tensao)
moda <- get_moda(tensao)
quartis <- quantile(tensao, probs = c(0.25, 0.5, 0.75))
decis <- quantile(tensao, probs = c(0.1, 0.5, 0.9))

cat(sprintf("\n> Média Aritmética: %.3f V", media))
cat(sprintf("\n> Mediana (Q2):     %.3f V", mediana))
cat(sprintf("\n> Moda:             %.3f V", moda))

cat("\n\n--- Separatrizes (Quartis e Decis) ---")
cat("\nQuartis (25%%, 50%%, 75%%): ", paste(quartis, collapse = " | "))
cat("\nDecis   (10%%, 50%%, 90%%): ", paste(decis, collapse = " | "))
cat("\n")


# ==============================================================================
# PARTE 3: MEDIDAS DE DISPERSÃO
# ==============================================================================
cat("\n==================== PARTE 3: MEDIDAS DE DISPERSÃO =====================\n")

amp_total <- diff(range(tensao))
desvio_padrao <- sd(tensao)
cv <- (desvio_padrao / media) * 100
iqr_val <- IQR(tensao)

cat(sprintf("\n> Amplitude Total:       %.2f V", amp_total))
cat(sprintf("\n> Desvio Padrão:         %.4f V", desvio_padrao))
cat(sprintf("\n> Coeficiente Variação:  %.2f %%", cv))
cat(sprintf("\n> Intervalo Interquartil: %.2f V", iqr_val))
cat("\n")


# ==============================================================================
# PARTE 4: ANÁLISE DE OUTLIERS (VALORES DISCREPANTES)
# ==============================================================================
cat("\n==================== PARTE 4: ANÁLISE DE OUTLIERS ======================\n")

lim_inf <- quartis[1] - 1.5 * iqr_val
lim_sup <- quartis[3] + 1.5 * iqr_val
outliers <- tensao[tensao < lim_inf | tensao > lim_sup]
dados_limpos <- tensao[tensao >= lim_inf & tensao <= lim_sup]

cat(sprintf("\n> Limite Inferior: %.2f V | Limite Superior: %.2f V", lim_inf, lim_sup))
cat("\n> Outliers Identificados:", if(length(outliers)>0) paste(outliers, collapse=", ") else "Nenhum")

media_limpa <- mean(dados_limpos)
sd_limpo <- sd(dados_limpos)

cat(sprintf("\n\nRECALCULADO (Sem Outliers):"))
cat(sprintf("\n> Nova Média:  %.3f V", media_limpa))
cat(sprintf("\n> Novo Desvio: %.4f V", sd_limpo))
cat("\n")


# ==============================================================================
# PARTE 6: CENÁRIO DE MELHORIA (SIMULAÇÃO DE AJUSTE)
# ==============================================================================
cat("\n==================== PARTE 6: CENÁRIO DE MELHORIA ======================\n")

tensao_ajustada <- ifelse(tensao < 4.5 | tensao > 5.5, 5.0, tensao)

resumo_comparativo <- data.frame(
  Medida = c("Média (V)", "Mediana (V)", "Desvio Padrão (V)", "CV (%)"),
  Original = c(media, mediana, desvio_padrao, cv),
  Ajustado = c(mean(tensao_ajustada), median(tensao_ajustada), 
               sd(tensao_ajustada), (sd(tensao_ajustada)/mean(tensao_ajustada))*100)
)

cat("\nCOMPARATIVO: SISTEMA ORIGINAL vs. SISTEMA AJUSTADO\n")
# Formatando a tabela para ficar alinhada
resumo_comparativo[,2:3] <- round(resumo_comparativo[,2:3], 4)
print(resumo_comparativo, row.names = FALSE)

cat("\n==============================================================================\n")
cat("ANÁLISE FINAL: O ajuste reduziu significativamente a dispersão (Desvio Padrão),\n")
cat("indicando que a estabilização de picos/quedas aumenta a confiabilidade do circuito.\n")
cat("==============================================================================\n")