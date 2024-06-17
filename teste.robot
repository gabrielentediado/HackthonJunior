*** Settings ***
#Biliotecas
Library    SeleniumLibrary        #Usa os sites
Library    OperatingSystem        #Cria arquivos

*** Variables ***
#Variaveis de URLS
${ucb}    https://ucb.catolica.edu.br/cursos-gerais

#Variavel do arquivo criado
${OUTPUT_FILE}    dados.txt

*** Test Cases ***
Capture And Save Data From Site
#Abre o site solicitado
    Open Browser    ${ucb}    firefox

#Click
    Click Element    xpath=//*[@id="coursesModule__content"]/div[1]/div[2]/a

    ${title}=    Get Title
    Append To File    ${OUTPUT_FILE}    Titulo: ${title}\n
    
#Pegar info 1
    ${header_text0}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[1]/div[2]
    Append To File    ${OUTPUT_FILE}    Tipo de curso: ${header_text0}\n
    
#Pegar info 2
    ${header_text1}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[2]/div[2]
    Append To File    ${OUTPUT_FILE}    Turnos: ${header_text1}\n

#Pegar info 3
    ${header_text2}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[3]/div[2]
    Append To File    ${OUTPUT_FILE}    Dias: ${header_text2}\n

#Pegar info 4
    ${header_text3}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[4]/div[2]
    Append To File    ${OUTPUT_FILE}    Duração: ${header_text3}
    
    Log    Data saved to file: ${OUTPUT_FILE}
