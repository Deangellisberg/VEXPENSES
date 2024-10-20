Infraestrutura AWS com Terraform
Este projeto configura uma infraestrutura básica na AWS utilizando o Terraform. A configuração inclui a criação de uma VPC, Subnet, Internet Gateway, Route Table, Security Group, e uma instância EC2 que instala automaticamente o servidor Nginx.
Requisitos
Antes de começar, certifique-se de ter os seguintes pré-requisitos instalados em seu ambiente:
•	Terraform >= 1.0.0
•	Uma conta AWS com permissões para criar recursos (VPC, EC2, Security Groups, etc.)
•	AWS CLI configurado com suas credenciais
Recursos Criados
Este projeto cria os seguintes recursos:
1.	VPC: Rede privada configurada com CIDR 10.0.0.0/16.
2.	Subnet: Sub-rede pública com CIDR 10.0.1.0/24 na zona de disponibilidade us-east-1a.
3.	Internet Gateway: Necessário para fornecer acesso à internet para a subnet.
4.	Route Table: Tabela de roteamento para permitir tráfego externo via Internet Gateway.
5.	Security Group: Configurado para permitir acesso SSH apenas de um IP específico e acesso HTTP de qualquer lugar.
6.	Instância EC2: Uma instância Debian configurada automaticamente para rodar o servidor web Nginx.
7.	CloudWatch Alarms: Um alarme básico para monitorar o uso de CPU da instância EC2.
Instalação e Uso
1. Clone o Repositório
bash
Copiar código
git clone https://github.com/seu-usuario/nome-do-repositorio.git
cd nome-do-repositorio
2. Configurar Variáveis
Abra o arquivo variables.tf e ajuste os valores conforme necessário. Em especial, altere:
•	var.candidato: Nome do candidato.
•	var.projeto: Nome do projeto.
•	Insira o IP específico no aws_security_group para acesso SSH seguro.
3. Inicializar o Terraform
Antes de executar o Terraform, inicialize o projeto:
bash
Copiar código
terraform init
4. Planejar a Infraestrutura
Revise os recursos que serão criados:
bash
Copiar código
terraform plan
5. Aplicar a Configuração
Para provisionar os recursos na AWS, execute:
bash
Copiar código
terraform apply
Digite yes quando solicitado.
6. Acessar a Instância EC2
Após a conclusão, você poderá acessar a instância EC2 via SSH usando a chave privada gerada pelo Terraform. No terminal, execute o seguinte comando:
bash
Copiar código
ssh -i caminho/para/chave.pem ubuntu@<EC2_PUBLIC_IP>
Substitua <EC2_PUBLIC_IP> pelo endereço IP público da instância, que será exibido como um dos outputs após a criação dos recursos.
Estrutura do Projeto
•	main.tf: Contém a definição principal de todos os recursos AWS.
•	variables.tf: Define as variáveis do projeto.
•	outputs.tf: Define os outputs, incluindo o IP público da instância EC2 e a chave privada.
•	provider.tf: Define o provedor AWS e a região.
Melhorias de Segurança e Automação
•	Acesso SSH Restrito: O acesso SSH é permitido apenas a um endereço IP específico para aumentar a segurança.
•	Automação do Nginx: O servidor Nginx é instalado e configurado automaticamente na instância EC2 após a criação.
•	Logs em Volume Separado: Os logs do Nginx são redirecionados para um volume EBS separado, garantindo que o volume principal da instância não fique sobrecarregado com logs.
•	Monitoramento com CloudWatch: Um alarme é configurado para monitorar a utilização da CPU da instância EC2.
Limpeza de Recursos
Para destruir os recursos criados, execute o comando:
bash
Copiar código
terraform destroy
Confirme a operação digitando yes quando solicitado.
Licença
Este projeto está licenciado sob a MIT License.
________________________________________
Este README fornece uma visão geral completa do projeto, bem como instruções claras para instalação, uso e limpeza dos recursos criados.


