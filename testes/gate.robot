```robot
*** Settings ***
Library    SeleniumLibrary

Suite Setup       Abrir navegador
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

CT01 - Porta AND com entradas 1 e 1 retorna saida 1
    Selecionar porta    AND
    Definir entrada A    1
    Definir entrada B    1
    Clicar em simular
    Resultado deve conter    "saida": 1

CT02 - Porta OR com entradas 0 e 0 retorna saida 0
    Selecionar porta    OR
    Definir entrada A    0
    Definir entrada B    0
    Clicar em simular
    Resultado deve conter    "saida": 0

CT03 - Porta NOT com entrada 1 retorna saida 0
    Selecionar porta    NOT
    Definir entrada A    1
    Clicar em simular
    Resultado deve conter    "saida": 0

CT04 - Porta XOR com entradas 1 e 1 retorna saida 0
    Selecionar porta    XOR
    Definir entrada A    1
    Definir entrada B    1
    Clicar em simular
    Resultado deve conter    "saida": 0

*** Keywords ***

Abrir navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${SELECT_GATE}    timeout=10s

Fechar navegador
    Close Browser

Selecionar porta
    [Arguments]    ${porta}
    Go To    ${URL}
    Wait Until Element Is Visible    ${SELECT_GATE}    timeout=10s
    Select From List By Value    ${SELECT_GATE}    ${porta}

Definir entrada A
    [Arguments]    ${valor}
    Select From List By Value    ${SELECT_A}    ${valor}

Definir entrada B
    [Arguments]    ${valor}
    Select From List By Value    ${SELECT_B}    ${valor}

Clicar em simular
    Click Button    ${BTN_GATE}
    Wait Until Element Is Visible    ${RESULT_GATE}    timeout=10s

Resultado deve conter
    [Arguments]    ${texto}
    Element Should Contain    ${RESULT_GATE}    ${texto}
```