require File.dirname(__FILE__) + '/abstract_unit'
require '../lib/validates_as_cpf'

# Modelo
class CPFData < ActiveRecord::Base
  set_table_name "cpfs"
end

# Testes
class CPFsTest < Test::Unit::TestCase
  def test_cpf_invalido
    CPFData.validates_as_cpf :cpf

    cpf_invalido = CPFData.create(:id => 1, :cpf => "542.123.456-98")
    cpf_invalido.save

    assert ( cpf_invalido.errors.on(:cpf) != nil ),
             "CPF invalido foi salvo."
  end

  def test_cpf_valido
    CPFData.validates_as_cpf :cpf

    cpf_valido = CPFData.create(:id => 1, :cpf => "804.932.540-72")
    cpf_valido.save

    assert ( cpf_valido.errors.on(:cpf) == nil ),
             "CPF valido nao foi salvo."
  end
end
