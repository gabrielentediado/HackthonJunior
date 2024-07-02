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

${cartorio_informacoes}    xpath=//*[@class="wixui-rich-text__text"]

${cartorio_informacoes_2}    xpath=//*[@class="wixui-rich-text__text"]

${titulos_apartamentos}    xpath=//*[@class="l-text l-u-color-neutral-28 -text--variant-heading-small l-text--weight-medium card__address"]

${preços}    xpath=//*[@class="l-text l-u-color-neutral-28 l-text--variant-heading-small l-text--weight-bold undefined"]

${metragem}    xpath=//*[@class="l-text l-u-color-neutral-28 l-text--variant-body-small l-text--weight-regular card__amenity"]

#arquivo
${OUTPUT_FILE}   dados.txt

*** Keywords ***

#fechar global
fechar 
    Close Browser

#Abrir o site 1
1- abrir cartorio
    Open Browser    ${cartorio}    firefox
    
#Clicar
2- clicar serviços

    Click Element    ${p_serviços}
    ${title}=        Get Title
    Append To File   ${OUTPUT_FILE}    Titulo: ${title}\n

e pegar info    
    ${header_text0}=    Get Text    ${cartorio_informacoes} 
    Append To File    ${OUTPUT_FILE}    Informações Cartório ${header_text0}\n
    Log    Data saved to file: ${OUTPUT_FILE}

e pegar info_2
    
    ${header_text0}=    Get Text    ${cartorio_informacoes_2} 
    Append To File    ${OUTPUT_FILE}    Informações Cartório ${header_text0}\n
    Log    Data saved to file: ${OUTPUT_FILE}


#Abrir o site 2
1- abrir imoveis
    Open Browser     ${imoveis_1}    firefox

e pegar preços

    ${count}=    Get Element Count    //div[@class="listing-price"]

    FOR    ${i}    IN RANGE    ${count}
        ${preco}=    Get Text    (//div[@class="listing-price"])[${i+1}]
        Append To File   ${OUTPUT_FILE}    Preços: ${preco}\n
    END

e pegar nomes imoveis
    
    ${count_2}=    Get Element Count    ${titulos_apartamentos}     

    FOR    ${i}    IN RANGE    ${count_2}
      
        ${titulos_imoveis}=    Get Text    ${titulos_apartamentos}[${i+1}]
        Append To file    ${OUTPUT_FILE}    Apartamentos: ${titulos_imoveis}\n 
    
    END

e pegar metros
    
    ${count_3}=    Get Element Count    ${metragem}            

    FOR    {i}    IN RANGE    ${count_3}    
        ${metros}=    Get Text    ${metragem}[${i+1}]
        Append To file    ${OUTPUT_FILE}    Apartamentos: ${metragem}\n         
    END

#abrir o site 3 

1- imoveis_2 
    Open Browser     ${imoveis_2}    ${browser}   

*** Test Cases ***

cenario 1
    [tags]  cartorio
    1- abrir cartorio
    2- clicar serviços
    e pegar info
   
    fechar

cenario 2
    [tags]  imovel
    1- abrir imoveis
    e pegar preços
    e pegar nomes imoveis
    fechar

cenario 3
    [tags]  imoveis_2

    1- imoveis_2 
    fechar