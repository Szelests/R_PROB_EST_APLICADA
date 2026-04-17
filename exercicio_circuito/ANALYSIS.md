import os

readme_content = """# Relatório de Estabilidade: Circuito Regulador de Tensão
## Engenharia Eletrônica - Estatística Descritiva

Este relatório apresenta a análise estatística de 40 medições de tensão de saída de um circuito regulador, cujo valor nominal ideal é **5,0 V**. O objetivo é avaliar a estabilidade do componente utilizando medidas de localização, dispersão e análise de outliers.

---

## 1. Organização e Visualização dos Dados

### Base de Dados (Rol Ordenado)
Os dados coletados (em Volts), ordenados do menor para o maior, são:
`3.8, 4.0, 4.2, 4.3, 4.4, 4.5, 4.5, 4.6, 4.7, 4.7, 4.7, 4.8, 4.8, 4.8, 4.9, 4.9, 4.9, 4.9, 5.0, 5.0, 5.0, 5.0, 5.0, 5.1, 5.1, 5.1, 5.1, 5.2, 5.2, 5.2, 5.2, 5.3, 5.3, 5.3, 5.4, 5.5, 5.6, 5.8, 6.0, 6.2`

### Critério de Agrupamento
Foi utilizada a **Regra de Sturges** ($k = 1 + 3.322 \\cdot \\log_{10}(n)$) para definir o número de classes. Para $n=40$, temos $k \\approx 6$ classes, garantindo uma distribuição equilibrada para a análise de frequência.

---

## 2. Resultados Estatísticos (Medidas de Localização)

| Medida | Valor Calculado |
| :--- | :--- |
| **Média** | 4,945 V |
| **Mediana** | 4,950 V |
| **Moda** | 5,000 V |
| **1º Quartil (Q1)** | 4,700 V |
| **3º Quartil (Q3)** | 5,200 V |

### Análise de Localização
* A média está extremamente próxima do valor ideal (5,0 V).
* A proximidade entre média e mediana indica que a distribuição dos dados é aproximadamente simétrica.
* A moda (5,0 V) coincide com o valor de projeto, sugerindo que o circuito atinge o objetivo na maioria das medições.

---

## 3. Medidas de Dispersão e Estabilidade

| Medida | Valor Calculado |
| :--- | :--- |
| **Amplitude Total** | 2,400 V |
| **Desvio Padrão** | 0,501 V |
| **Coeficiente de Variação (CV)** | 10,14 % |
| **Intervalo Interquartil (IQR)** | 0,500 V |

---

## 4. Respostas aos Questionamentos Técnicos

### Parte 4 - Valores Discrepantes (Outliers)
**Pergunta:** Esses valores são erro de medição ou comportamento real do circuito?
**Resposta:** Estatisticamente, valores como 3,8V e 6,2V são identificados como outliers. Na engenharia, estes representam **instabilidades transientes** (picos ou quedas de tensão). Embora possam ser erros de leitura, em um regulador de tensão eles indicam falhas de filtragem sob carga, sendo, portanto, comportamento real e preocupante do hardware.

### Parte 5 - Interpretação de Engenharia (Tópico Principal)
**1. O circuito é estável, moderadamente estável ou instável?**
O circuito é **Moderadamente Estável**.

**2. Justificativa:**
O Coeficiente de Variação (CV) de **10,14%** coloca o circuito no limite da estabilidade aceitável (geralmente < 10%). Embora a média seja boa, a amplitude de 2,4V é muito alta para eletrônica de precisão, indicando que o circuito sofre variações significativas em condições extremas.

**3. Qual medida melhor representa o comportamento?**
O **Coeficiente de Variação (CV)**, pois ele padroniza o desvio padrão em relação à média, permitindo entender a precisão relativa do regulador independente da escala de tensão.

### Parte 6 - Cenário de Melhoria
**1. A estabilidade melhorou?**
Sim, drasticamente. Ao restringir os valores ao intervalo [4.5, 5.5], eliminamos os picos de ruído.

**2. Qual medida melhor mostrou essa melhoria?**
O **Desvio Padrão**. Ele reduz drasticamente no cenário ajustado, provando que a dispersão em torno do centro (5,0 V) diminuiu, resultando em um sinal mais limpo.

---

## 5. Script R Utilizado
```R
# Dados
tensao <- c(4.8, 4.9, 5.0, 5.1, 5.0, 4.7, 4.6, 5.2, 5.3, 4.9,
            5.0, 5.1, 5.2, 5.4, 5.5, 4.5, 4.4, 4.8, 4.9, 5.0,
            5.1, 5.2, 5.3, 5.6, 5.8, 4.3, 4.2, 4.7, 4.8, 4.9,
            5.0, 5.1, 5.2, 5.3, 6.0, 6.2, 3.8, 4.0, 4.5, 4.7)

# Analise
summary(tensao)
sd(tensao)
cv <- (sd(tensao)/mean(tensao))*100
cat("CV:", cv, "%")