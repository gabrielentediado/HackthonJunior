*** Settings ***
Library    SeleniumLibrary
Library    RPA.Excel.Files

*** Variables ***
${ucb}    https://ucb.catolica.edu.br/cursos-gerais
${OUTPUT_FILE}    captured_data.xlsx

*** Test Cases ***
Capture And Save Data To Excel
    # Abre o site solicitado
    Open Browser    ${ucb}    firefox
    
    # Click
    Click Element    xpath=//*[@id="coursesModule__content"]/div[1]/div[2]/a
    
    ${title}=    Get Title
    ${header_text0}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[1]/div[2]
    ${header_text1}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[2]/div[2]
    ${header_text2}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[3]/div[2]
    ${header_text3}=    Get Text    xpath=//*[@id="hs_cos_wrapper_module_1697023447861675"]/div/div[4]/div[2]
    
    # Criação do arquivo Excel e adição dos dados capturados
    Create Workbook    ${OUTPUT_FILE}
    Create Worksheet    index=0    name=Sheet1
    Set Cell Value    Sheet1    A1    Título
    Set Cell Value    Sheet1    B1    ${title}
    Set Cell Value    Sheet1    A2    Tipo de curso
    Set Cell Value    Sheet1    B2    ${header_text0}
    Set Cell Value    Sheet1    A3    Turnos
    Set Cell Value    Sheet1    B3    ${header_text1}
    Set Cell Value    Sheet1    A4    Dias
    Set Cell Value    Sheet1    B4    ${header_text2}
    Set Cell Value    Sheet1    A5    Duração
    Set Cell Value    Sheet1    B5    ${header_text3}
    Save Workbook

    Log    Data saved to Excel file: ${OUTPUT_FILE}
    Close Browser
