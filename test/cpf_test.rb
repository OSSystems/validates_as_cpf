require File.dirname(__FILE__) + '/abstract_unit'
require '../lib/validates_as_cpf'

# Modelo
class CPFData < ActiveRecord::Base
  set_table_name "cpfs"
  
  validates_as_cpf :cpf
end

# Testes
class CPFsTest < Test::Unit::TestCase
  def test_cpf_invalido
    cpf_invalido = CPFData.create(:id => 1, :cpf => "542.123.456-98")
 
    assert ( not cpf_invalido.save ), "CPF invalido foi salvo."
  end

  def test_cpf_valido
    cpf_valido = CPFData.create(:id => 1, :cpf => "804.932.540-72")

    assert ( cpf_valido.save ), "CPF valido nao foi salvo."
  end
end
