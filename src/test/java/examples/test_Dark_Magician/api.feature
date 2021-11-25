Feature: Executar testes funcionais na api Yu-Gi-Oh!

Background: Executa antes de cada teste
    * def url_base = 'https://db.ygoprodeck.com/api/v7/cardinfo.php'

Scenario: Verificar se a API responde 
    Given url url_base
    And path '?name=Dark_Magician'
    When method get
    Then status 200

Scenario: Verificar se a API retorna Bad Request 
    Given url url_base
    And path '?naxsxsme=Dark_Magician'
    When method get
    Then status 400

Scenario: Verificar o nome e o id da carta Dark Magician
    Given url url_base
    And path '?name=Dark_Magician'
    When method get
    Then status 200
    And match response.data[0].id == 46986421
    And match response.data[0].name == "Dark Magician"

Scenario: Verificar o tipo das variaveis das cartas
    Given url url_base
    And path '?name=Dark_Magician'
    When method get
    Then status 200
    And match response.data[0].card_sets =='#[]'
    And match each response.data[0].card_sets contains { set_name: "#string", set_code: "#string", set_rarity: "#string", set_rarity_code: "#string", set_price: "#string" }

Scenario: Verificar se a carta tem valor maior ou igual a "0"
    Given url url_base
    And path '?name=Dark_Magician'
    When method get
    Then status 200
    And match each response.data[0].card_sets contains { set_price: '#? _ >= 0' }

Scenario: Verificar se o preco da primeira prova e igual a 11.37
    Given url url_base
    And path '?name=Dark_Magician'
    When method get
    Then status 200
    And match response.data[0].card_sets[0] contains { set_price: '11.37' }
    

