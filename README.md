## Implementação do projeto

Requsiitos:
- Terraform instalado
- Credencias da AWS configuradas

### Instruções
Clone o repositório na sua máquina:
```bash
  git clone https://github.com/9Solutions/caixadesapato-terraform.git
```

No mesmo diretório, execute o comando abaixo para instalar as depedências do terraform:
```bash
  terraform init
```

Em seguida, execute o comando abaixo para subir os recursos na sua conta da AWS:
```bash
  terraform apply
```

### Diagramas
Rede:
![Diagrama de Rede](./src/architecture-files/arquitetura-de-rede.png)

Arquitetura da solução:
![Diagrama de Rede](./src/architecture-files/arquitetura-infra.png)
