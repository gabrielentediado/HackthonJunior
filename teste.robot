*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    DatabaseLibrary

*** Variables ***
${cartorio}    https://www.cartoriodetaguatinga.com.br/
${imoveis}    https://www.zapimoveis.com.br/venda/imoveis/df+brasilia/
${imoveis_2}    https://www.vivareal.com.br/

${p_serviços}    //*[@id="comp-ihjax7ir1label"]
${div_notariado}    //*[@id="comp-ihjax7irmoreContainer"]

${OUTPUT_FILE}   dados.txt

*** Keywords ***
1- abrir cartorio
    Open Browser    ${cartorio}    firefox

2- clicar serviços
    Click Element    ${p_serviços}
    ${title}=        Get Title
    Append To File   ${OUTPUT_FILE}    Titulo: ${title}\n
    ${header_text0}=    Get Text    ${div_notariado}
    Append To File   ${OUTPUT_FILE}    E-notoriado: ${header_text0}\n
    Log    Data saved to file: ${OUTPUT_FILE}

1- abrir imoveis
    Open Browser     ${imoveis}    firefox

e pegar preços
    ${count}=    Get Element Count    //div[@class="listing-price"]
    FOR    ${i}    IN RANGE    ${count}
        ${preco}=    Get Text    (//div[@class="listing-price"])[${i+1}]
        Append To File   ${OUTPUT_FILE}    Preços: ${preco}\n
    END

1- abrir imoveis_2
    Open Browser     ${imoveis_2}    firefox

fechar 
    Close Browser

*** Test Cases ***
cenario 1
    [Tags]    cartorio
    1- abrir cartorio
    2- clicar serviços
    fechar

cenario 2
    [Tags]    imovel
    1- abrir imoveis
    e pegar preços
    fechar

cenario 3
    [Tags]    imoveis_2
    1- abrir imoveis_2
    fechar
