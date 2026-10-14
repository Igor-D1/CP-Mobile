import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Restaurante_Mesa_Cheia/models/clientes.dart';
import 'package:Restaurante_Mesa_Cheia/widgets/pessoa_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pessoa> _pessoas = [];
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  static const int _capacidadeMaxima = 50;

  int get _pessoasNoAmbiente => _pessoas.where((p) => p.noAmbiente).length;
  bool get _ambienteLotado => _pessoasNoAmbiente >= _capacidadeMaxima;

  @override
  void dispose() {
    _nomeController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _snack(String msg, {bool erro = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: erro ? const Color(0xFFB3261E) : const Color(0xFF2E7D32),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _cadastrar() {
    final nome = _nomeController.text.trim();
    final id = _idController.text.trim();

    if (nome.isEmpty || id.isEmpty) {
      _snack('Preencha todos os campos obrigatórios.', erro: true);
      return;
    }
    if (_ambienteLotado) {
      _snack('Não é possível realizar a entrada. Ambiente lotado!', erro: true);
      return;
    }
    if (_pessoas.any((p) => p.identificacao == id)) {
      _snack('Já existe uma pessoa com esta identificação.', erro: true);
      return;
    }

    setState(() {
      _pessoas.add(Pessoa(
        nome: nome,
        identificacao: id,
        dataEntrada: DateTime.now(),
      ));
    });
    _nomeController.clear();
    _idController.clear();
    _snack('Pessoa cadastrada com sucesso!');
  }

  void _registrarSaida(Pessoa pessoa) {
    if (!pessoa.noAmbiente) {
      _snack('Esta pessoa já saiu do ambiente.', erro: true);
      return;
    }
    setState(() => pessoa.registrarSaida());
    _snack('Saída registrada com sucesso!');
  }

  void _excluir(Pessoa pessoa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: Text(
            'Deseja realmente excluir o registro de ${pessoa.nome}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _pessoas.remove(pessoa); 
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${pessoa.nome} excluído(a) com sucesso!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('EXCLUIR'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmarSaida(Pessoa pessoa) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar saída?'),
        content: Text('Deseja realmente registrar a saída de ${pessoa.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
    if (confirmou == true) _registrarSaida(pessoa);
  }

  void _confirmarLimparTudo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Limpar tudo'),
          content: const Text(
            'Deseja realmente apagar todos os registros da lista?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _pessoas.clear();
                });
                _snack('Todos os registros foram removidos!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('LIMPAR TUDO'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controle de Lotação'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            _capCard(),
            const SizedBox(height: 12),
            _formulario(),
            if (_pessoas.length > 5) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Tooltip(
                  message: 'Remove todos os registros da lista de uma vez',
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _confirmarLimparTudo,
                      icon: const Icon(Icons.delete_sweep, color: Colors.red),
                      label: const Text(
                        'Limpar Tudo',
                        style: TextStyle(color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),
            Expanded(
              child: _pessoas.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: _pessoas.length,
                      itemBuilder: (context, index) {
                        final p = _pessoas[index];
                        return PessoaItem(
                          pessoa: p,
                          onSaida: () => _confirmarSaida(p),
                          onExcluir: () => _excluir(p),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _capCard() {
    final fracao = _pessoasNoAmbiente / _capacidadeMaxima;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF7B2D26), Color(0xFF5C211C)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pessoas no ambiente',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '$_pessoasNoAmbiente / $_capacidadeMaxima',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: fracao.clamp(0.0, 1.0),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.white24,
            color: fracao >= 1.0
                ? const Color(0xFFF44336)
                : fracao >= 0.8
                    ? const Color(0xFFD9A441)
                    : const Color(0xFF81C784),
          ),
          const SizedBox(height: 8),
          Text(
            _ambienteLotado ? 'Ambiente lotado!' : 'Capacidade máxima: $_capacidadeMaxima',
            style: TextStyle(
              color: _ambienteLotado ? const Color(0xFFFFCDD2) : Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formulario() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Tooltip(
            message: 'Digite o nome completo da pessoa',
            child: TextField(
              controller: _nomeController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Nome da pessoa',
                prefixIcon: const Icon(Icons.person_outline),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Tooltip(
                  message: 'Digite o número de identificação ou matrícula',
                  child: TextField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Identificação / Matrícula',
                      prefixIcon: const Icon(Icons.badge_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Tooltip(
                message: 'Cadastra a entrada da pessoa no restaurante',
                child: SizedBox(
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: _cadastrar,
                    icon: const Icon(Icons.add),
                    label: const Text('Entrada'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant_menu, size: 64, color: Color(0xFFD9A441)),
          const SizedBox(height: 12),
          Text(
            'Nenhuma pessoa registrada ainda',
            style: GoogleFonts.lato(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}