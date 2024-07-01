*** Settings ***
#Biliotecas
Library    SeleniumLibrary        #Usa os sites
Library    OperatingSystem        #Cria arquivos
Library    DatabaseLibrary        #Banco de dados

*** Variables ***
#Variaveis de URLS
${cartorio}    https://www.cartoriodetaguatinga.com.br/
${imoveis_1}    https://www.zapimoveis.com.br/venda/imoveis/df+brasilia/
${imoveis_2}    https://www.vivareal.com.br/
${browser}    firefox
${p_serviços}    //*[@id="comp-ihjax7ir1label"]
${div_notariado} //*[@id="comp-ihjax7irmoreContainer"]

${titulos_apartamentos}    //*@class=["l-text l-u-color-neutral-28 -text--variant-heading-small l-text--weight-medium card__address"]

${preços}    //*[@class="l-text l-u-color-neutral-28 l-text--variant-heading-small l-text--weight-bold undefined"]

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
    Open Browser     ${imoveis_1}    firefox

e pegar preços
    ${count} =    Get Element Count    name:$

    FOR    {i}    IN RANGE    1    ${count}    
        LOG TO CONSOLE    ${i}    
        ${minha_string}    Get Text    ${preços}
        Append To File   ${OUTPUT_FILE}    Preços: ${minha_string}\n
    END

#fechar global
fechar 
    Close Browser
    
e pegar nomes imoveis
    
    ${count_2}=    Get Element Count    data-cy:card__address       

    FOR    {I}    IN RANGE    1    ${count_2}
      
        ${titulos_imoveis}    Get Text    ${titulos_apartamentos}
        Append To file    ${OUTPUT_FILE}    Apartamentos: ${titulos_imoveis} 
    
    END
    

#abrir o site 3 

1- imoveis_2 
    Open Browser     ${imoveis_2}    ${browser}   

*** Test Cases ***

cenario 1
    [tags]  cartorio
    1- abrir cartorio
    2- clicar serviços
    e pegar info 1
   
    fechar

cenario 2
    [tags]  imovel
    1- abrir imoveis
    e pegar preços
    e pegar nomes imoveis
    fechar

cenario 3
    [tags]  imoveis_2

    1-abrir imoveis_2
    fechar
