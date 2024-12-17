# 🔍 Análise Exploratória de Dados (E-commerce)

## **Objetivo da Análise**

A análise exploratória de dados (AED) é um processo essencial para entender a estrutura, a qualidade e os principais padrões nos dados disponíveis. No contexto deste banco de dados de **E-commerce**, a AED busca responder **15 perguntas de negócio** que fornecem insights valiosos para a tomada de decisões estratégicas.

## **Importância da Análise**

O mercado de **E-commerce** é extremamente competitivo e baseado em decisões orientadas por dados. A análise exploratória ajuda a:

- 📊 **Identificar padrões de comportamento** de clientes e produtos.
- 🚀 **Aprimorar a gestão de estoque e fornecedores**.
- 📈 **Otimizar o desempenho de vendas** com base em dados históricos.
- 🔎 **Detectar problemas ou gargalos** que possam afetar a operação.
- 🎯 **Criar estratégias mais eficazes** para atender às necessidades dos clientes e impulsionar as vendas.

---

## **Perguntas de Negócio e Sua Importância**

### **1. Quantos clientes únicos existem na base de dados?**
   - **Importância**: Entender a base de clientes é essencial para calcular métricas como o crescimento do público e definir estratégias de retenção e aquisição.

### **2. Qual é o produto mais vendido e qual o menos vendido?**
   - **Importância**: Identifica os produtos de maior sucesso e aqueles com baixo desempenho, ajudando a otimizar estoques e campanhas de marketing.

### **3. Qual o total financeiro de vendas por mês, ano, status e SKU do produto?**
   - **Importância**: A consulta fornece uma análise detalhada do desempenho financeiro das vendas, agrupando os dados por mês, ano, status do pedido e SKU dos produtos.

### **4. Qual cliente realizou o maior número de pedidos?**
   - **Importância**: Identifica clientes de alto valor (VIPs) para ações de fidelização e atendimento personalizado.

### **5. Quantos pedidos foram realizados em cada mês?**
   - **Importância**: Revela padrões sazonais nas vendas, ajudando a planejar ações de marketing e gestão de estoque.

### **6. Qual é a média de quantidade de produtos por pedido?**
   - **Importância**: Auxilia na compreensão do comportamento de compra dos clientes e no planejamento do inventário.

### **7. Quais produtos estão com o estoque abaixo de um limite crítico (ex: menos de 10 unidades)?**
   - **Importância**: Evita a ruptura de estoque e garante que os produtos mais vendidos estejam sempre disponíveis.

### **8. Qual é a receita gerada por cada categoria de produto?**
   - **Importância**: Avalia o desempenho das categorias, permitindo decisões estratégicas sobre investimentos e promoções.

### **9. Qual foi o pedido de maior valor já realizado?**
   - **Importância**: Fornece insights sobre grandes transações e identifica clientes com potencial de alto valor.

### **10. Qual fornecedor fornece o maior número de produtos?**
   - **Importância**: Identifica os fornecedores mais relevantes, facilitando negociações e gerenciamento de parcerias.

### **11. Quantos clientes ainda estão ativos (coluna `is_active`)?**
   - **Importância**: Mostra a retenção de clientes e a necessidade de estratégias de reativação.

### **12. Qual cidade tem a maior concentração de clientes?**
   - **Importância**: Permite direcionar campanhas de marketing para regiões com alta densidade de clientes.

### **13. Quais são os status mais comuns dos pedidos (ex: "Entregue", "Pendente")?**
   - **Importância**: Avalia o desempenho logístico e ajuda a identificar problemas no fluxo de entrega.

### **14. Qual é a média de tempo entre o pedido e a entrega?**
   - **Importância**: Mensura a eficiência do processo de entrega e identifica áreas de melhoria.

### **15. Quais os produtos mais fornecidos por vendedores de marketplace?**
   - **Importância**: Ajuda a identificar tendências no marketplace e a analisar a competitividade dos produtos.

---

## 📂 **Conteúdo da Pasta**

- **`analise_exploratoria.sql`**: Contém todas as queries SQL que respondem às 15 perguntas de negócio.
- **Explicação detalhada**: Cada query está comentada no script, destacando a **pergunta respondida** e sua **relevância**.
- **Resultados**: Os resultados obtidos a partir das queries fornecem insights acionáveis e práticos para o negócio de E-commerce.

---

## 📊 **Como Utilizar**

1. Certifique-se de ter criado e populado o banco de dados com o script principal.
2. Execute o arquivo `analise_exploratoria.sql` em sua ferramenta SQL (ex: MySQL Workbench).
3. Analise os resultados retornados por cada query.
4. Combine os insights gerados com ferramentas como **Power BI** para criar visualizações e dashboards interativos.

---

## 🚀 **Próximos Passos**

- Use os insights da análise exploratória para sugerir melhorias no sistema de E-commerce, como:
   - Estratégias de **vendas e marketing**.
   - **Reabastecimento de estoque**.
   - Melhorias no **tempo de entrega**.
- Exporte os resultados e visualize-os em **relatórios interativos** usando Power BI ou outra ferramenta de BI.
- Compartilhe os resultados com stakeholders para facilitar a tomada de decisões baseada em dados.

---

📌 **Este arquivo complementa o projeto principal, demonstrando a capacidade de transformar dados brutos em informações útis para o negócio.**

