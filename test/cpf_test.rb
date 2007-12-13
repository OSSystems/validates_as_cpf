require File.dirname(__FILE__) + '/abstract_unit'
require '../lib/validates_as_cpf'

# Modelo
class CPFData < ActiveRecord::Base
  set_table_name "cpfs"
  
  validates_as_cpf :cpf
end

# Testes
class CPFsTest < Test::Unit::TestCase
  def test_deixa_passar_cpf_nulo_porque_devemos_barrar_com_validates_presence_of
    cpf_valido = CPFData.new(:id => 1, :cpf => nil)
    
    assert cpf_valido.save, "Nao salvou CPF nulo"
  end
  
  def test_deixa_passar_cpf_vazio_porque_devemos_barrar_com_validates_presence_of
    cpf_valido = CPFData.new(:id => 1, :cpf => "")
    
    assert cpf_valido.save, "Nao salvou CPF em branco"
  end
  
  def test_cpf_invalido_sem_pontuacao
    cpf_invalido = CPFData.new(:id => 1, :cpf => "00000000000")
    
    assert (not cpf_invalido.save), "CPF invalido foi salvo"
  end
  
  def test_cpf_valido_sem_pontuacao
    cpf_valido = CPFData.new(:id => 1, :cpf => "88318850068")
    
    assert cpf_valido.save, "CPF valido nao foi salvo"
  end
  
  def test_cpf_invalido_sem_pontuacao
    cpf_invalido = CPFData.new(:id => 1, :cpf => "10000007898")
    
    assert (not cpf_invalido.save), "CPF invalido foi salvo"
  end
  
  def test_cpf_invalido_com_letras
    cpf_invalido = CPFData.create(:id => 1, :cpf => "abcdefghijk")

    assert ( not cpf_invalido.save ), "CPF invalido (contem letras) foi salvo."
  end
  
  def test_cpf_invalido
    cpf_invalido = CPFData.create(:id => 1, :cpf => "542.123.456-98")

    assert ( not cpf_invalido.save ), "CPF invalido foi salvo."
  end

  def test_cpf_valido
    cpf_valido = CPFData.create(:id => 1, :cpf => "804.932.540-72")

    assert ( cpf_valido.save ), "CPF valido nao foi salvo."
  end

  def test_cpf_valido_com_bignum
    cpf_valido = CPFData.create(:id => 1, :cpf => 80493254072)

    assert(( cpf_valido.save ), 
           "CPF valido com valor de classe Bignum nao foi salvo.")

#    andre: inteiro comecando com zero converte numero octal para decimal
#    irb(main):001:0> 01362421030
#    => 197796376
#    irb(main):002:0> 01362421030.to_s(8)
#    => "1362421030"
#    irb(main):003:0> 01362421030.to_s(10)
#    => "197796376"
#
#    cpf_valido = CPFData.create(:id => 2, :cpf => 01362421030)

#    assert(( cpf_valido.save ), 
#           "CPF valido iniciando com zero nao foi salvo.")
  end
end
