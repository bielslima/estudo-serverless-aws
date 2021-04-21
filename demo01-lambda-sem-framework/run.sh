  # 1 - Criar arquivo de políticas de segurança (politicas.json)
# 2 - Criar Role de segurança AWS

aws iam create-role --role-name lambda-exemplo2 --assume-role-policy-document file://politicas.json | tee logs/role.log

# 3 - Criar arquivo com conteúdo da function e zipa-lo
zip function.zip index.js
aws lambda create-function --function-name hello-cli --zip-file fileb://functions.zip --handler index.handler --runtime nodejs12.x --role arn:aws:iam::453642495907:role/lambda-exemplo2 | tee logs/lambda-create.log

# 4 - Invoke lambda!
aws lambda invoke --function-name hello-cli --log-type Tail logs/lambda-exec.log

# Atualizar, zipar 
zip function.zip index.js

#atualizar lambda
aws lambda update-function-code --zip-file fileb://function.zip --function-name hello-cli --publish | tee logs/lambda-update.log

#Invocar e ver o resultado 
aws lambda invoke --function-name hello-cli --log-type Tail logs/lambda-exec.log


#remover
aws lambda delete-function --function-name hello-cli
aws iam delete-role --role-name lambda-exemplo2
