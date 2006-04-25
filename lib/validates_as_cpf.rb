module ValidaCPF
  def self.valida_cpf(cpf = nil)
    return nil if cpf.nil?
    
    nulos = %w{12345678909
               11111111111
               22222222222
               33333333333
               44444444444
               55555555555
               66666666666
               77777777777
               88888888888
               99999999999
               00000000000}

    valor = cpf.scan /[0-9]/
    
    if valor.length == 11
      unless nulos.member?(valor.join)
        valor = valor.collect{|x| x.to_i}
       
        # Calcula o primeiro digito verificador
        soma = 0
        0.upto(8) do |i|
          soma += valor[i] * (10 - i)
        end
        
        soma = soma - (11 * (soma/11))
        dv1 = soma < 2 ? 0 : 11 - soma
        
        if dv1 == valor[9]
          # Calcula o segundo digito verificador
          soma = 0
          0.upto(8) do |i|
            soma += valor[i] * (11 - i)
          end

          soma += dv1 * 2
          valorr = (soma / 11) * 11
          resultado = soma - valorr
          dv2 = resultado < 2 ? 0 : 11 - resultado

          return true if dv2 == valor[10]
        end
      end
    end
    return nil
  end
end

module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_cpf(*attr_names)
        configuration = { :message => "cpf inválido" }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_each(attr_names, configuration) do |record, attr_name, value|
          value_before_type_cast = record.send("#{attr_name}_before_type_cast")
          
          next if value.empty?
          
          unless ValidaCPF::valida_cpf(value)
            record.errors.add(attr_name, configuration[:message])
          end
        end
      end
    end
  end
end
