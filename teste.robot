*** Settings ***
#Biliotecas
Library    SeleniumLibrary        #Usa os sites
Library    OperatingSystem        #Cria arquivos
Library    DatabaseLibrary        #Banco de dados

*** Variables ***
#Variaveis de URLS
${cartorio}    https://www.cartoriodetaguatinga.com.br/
${imoveis}    https://www.zapimoveis.com.br/venda/imoveis/df+brasilia/
${imoveis_2}    https://www.vivareal.com.br/

${p_serviços}    //*[@id="comp-ihjax7ir1label"]
${div_notariado} //*[@id="comp-ihjax7irmoreContainer"]

#variaveis banco de dados

#${DBHost}          localhost
#${DBName}          my_database
#${DBUser}          my_user
#${DBPass}          my_password
#${DBPort}          5432

#arquivo
${OUTPUT_FILE}   dados.txt

*** Keywords ***
#Abrir o site 1
1- abrir cartorio
    Open Browser    ${cartorio}    firefox
#Clicar
2- clicar serviços

    Click Element    ${p_serviços}
    ${title}=        Get Title
    Append To File   ${OUTPUT_FILE}    Titulo: ${title}\n

e pegar info    
    ${header_text0}=    Get Text    ${div_notariado} 
    Append To File    ${OUTPUT_FILE}    E-notoriado ${header_text0}\n
    Log    Data saved to file: ${OUTPUT_FILE}


#Abrir o site 2
1- abrir imoveis
    Open Browser     ${imoveis}    firefox

e pegar preços
    ${count} =    Get Element Count    name:$

    FOR    {i}    IN RANGE    ${count}
        ${minha_string}    Get Text    //div[@class="listing-price"]
        Append To File   ${OUTPUT_FILE}    Preços: ${minha_string}\n

    #${resultado}    Evaluate    ${minha_string}.rfind('$') + 1
    
#abrir o site 3 

1- imoveis_2 
    Open Browser     ${imoveis_2}    firefox

#fechar global
fechar 
    Close Browser

*** Test Cases ***

cenario 1
    [tags] cartorio
    1- abrir cartorio
    2- clicar serviços
    e pegar info 1
   
    fechar

cenario 2
    [tags]  imovel
    1- abrir imoveis
    e pegar preços

cenario 3
    [tags] imoveis_2
    1-abrir imoveis_2