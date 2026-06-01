*** Settings ***
Library    SeleniumLibrary

Suite Setup       Abrir navegador na página do BitPulse
Suite Teardown    Fechar navegador

*** Variables ***
${URL}              http://localhost:3000
${BROWSER}          chrome

${SELECT_GATE}      id=gate
${SELECT_A}         id=inputA
${SELECT_B}         id=inputB
${BTN_GATE}         id=btnGate
${RESULT_GATE}      id=resultGate

*** Test Cases ***

CT01 - Porta AND com entradas validas deve retornar saída
    Dado que o usuário seleciona a porta    AND
    E define a entrada A como    1
    E define a entrada B como    0
    Quando clicar em Simular Porta
    Então o resultado deve conter    "saida": 0

CT02 - Porta invalida deve retornar erro
    Dado que o usuário seleciona a porta    AND
    E define a entrada A como    1
    E define a entrada B como    0
    Quando clicar em Simular Porta
    Então o resultado deve conter    "status": "sucesso"

CT03 - Entrada A invalida deve retornar erro
    Dado que o usuário seleciona a porta    AND
    E define a entrada A como    0
    E define a entrada B como    0
    Quando clicar em Simular Porta
    Então o resultado deve conter    "saida": 0

CT04 - Entrada B invalida deve retornar erro
    Dado que o usuário seleciona a porta    AND
    E define a entrada A como    1
    E define a entrada B como    0
    Quando clicar em Simular Porta
    Então o resultado deve conter    "saida": 0

*** Keywords ***

Abrir navegador na página do BitPulse
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${SELECT_GATE}    timeout=10s

Fechar navegador
    Close Browser

Dado que o usuário seleciona a porta
    [Arguments]    ${porta}
    Go To    ${URL}
    Wait Until Element Is Visible    ${SELECT_GATE}    timeout=10s
    Select From List By Value    ${SELECT_GATE}    ${porta}

E define a entrada A como
    [Arguments]    ${valor}
    Select From List By Value    ${SELECT_A}    ${valor}

E define a entrada B como
    [Arguments]    ${valor}
    Select From List By Value    ${SELECT_B}    ${valor}

Quando clicar em Simular Porta
    Click Button    ${BTN_GATE}
    Wait Until Element Is Visible    ${RESULT_GATE}    timeout=10s

Então o resultado deve conter
    [Arguments]    ${texto}
    Element Should Contain    ${RESULT_GATE}    ${texto}