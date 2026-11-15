class Validators {
  static String? email(String? valor) {
    if (valor == null || !valor.contains('@') || !valor.contains('.')) {
      return 'Informe um e-mail válido';
    }
    return null;
  }

  static String? senha(String? valor) {
    return obrigatorio(valor);
  }

  static String? obrigatorio(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? quantidade(String? valor) {
    final numero = int.tryParse(valor ?? '');

    if (numero == null || numero <= 0) {
      return 'Informe uma quantidade maior que zero';
    }
    return null;
  }

  static String? estoque(String? valor) {
    final numero = int.tryParse(valor ?? '');

    if (numero == null || numero < 0) {
      return 'Informe um estoque válido';
    }
    return null;
  }

  static String? telefone(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o telefone';
    }

    if (valor.length > 20) {
      return 'Telefone muito longo';
    }

    return null;
  }
}
