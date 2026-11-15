class Validators {
  static String? email(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe seu e-mail';
    }

    if (!valor.contains('@') || !valor.contains('.')) {
      return 'E-mail inválido';
    }

    return null;
  }

  static String? senha(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Informe sua senha';
    }

    return null;
  }
}
