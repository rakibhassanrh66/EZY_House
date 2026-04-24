import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/presentation/providers/result_provider.dart';
import 'package:task/presentation/widgets/sci_fi_ui.dart';
import 'package:task/domain/models/student_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _digitsCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _digitsCtrl = TextEditingController();
    context.read<ResultProvider>().init().then((_) {
      final p = context.read<ResultProvider>();
      _nameCtrl.text = p.name;
      _digitsCtrl.text = p.digits;
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _digitsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ResultProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result Dashboard',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              provider.reset();
              _nameCtrl.clear();
              _digitsCtrl.clear();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return _buildDesktop(provider, theme);
          }
          return _buildMobile(provider, theme);
        },
      ),
    );
  }

  Widget _buildMobile(ResultProvider p, ThemeData t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SciFiTextField(
            label: 'Student Name',
            controller: _nameCtrl,
            onChanged: p.updateName,
          ),
          const SizedBox(height: 16),
          SciFiTextField(
            label: 'Last 4 ID Digits',
            controller: _digitsCtrl,
            onChanged: p.updateDigits,
            keyboardType: TextInputType.number,
            maxLength: 4,
          ),
          const SizedBox(height: 20),
          if (p.error.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: t.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: t.colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      p.error,
                      style: TextStyle(color: t.colorScheme.onErrorContainer),
                    ),
                  ),
                ],
              ),
            ),
          SciFiButton(
            text: p.isLoading ? 'Analyzing...' : 'Calculate Result',
            onPressed: p.isLoading ? null : p.calculate,
          ),
          const SizedBox(height: 32),
          if (p.result != null) _buildResultCard(p.result!, t),
        ],
      ),
    );
  }

  Widget _buildDesktop(ResultProvider p, ThemeData t) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SciFiTextField(
                  label: 'Student Name',
                  controller: _nameCtrl,
                  onChanged: p.updateName,
                ),
                const SizedBox(height: 20),
                SciFiTextField(
                  label: 'Last 4 ID Digits',
                  controller: _digitsCtrl,
                  onChanged: p.updateDigits,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
                const SizedBox(height: 20),
                if (p.error.isNotEmpty) _buildError(p.error, t),
                SciFiButton(
                  text: p.isLoading ? 'Analyzing...' : 'Calculate Result',
                  onPressed: p.isLoading ? null : p.calculate,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: p.result != null
                ? _buildResultCard(p.result!, t)
                : const SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(StudentResult r, ThemeData t) {
    final isPass = r.status == 'PASS';
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '👤 ${r.name}',
              style: t.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildDataRow('Subject 1', r.marks[0], t),
            _buildDataRow('Subject 2', r.marks[1], t),
            _buildDataRow('Subject 3', r.marks[2], t),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: t.textTheme.titleMedium),
                Text(
                  '${r.total}/300',
                  style: t.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Average', style: t.textTheme.titleMedium),
                Text(
                  r.average.toStringAsFixed(1),
                  style: t.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isPass
                      ? t.colorScheme.primaryContainer
                      : t.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '🎓 ${r.status}',
                  style: TextStyle(
                    color: isPass
                        ? t.colorScheme.onPrimaryContainer
                        : t.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String sub, int mark, ThemeData t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sub, style: t.textTheme.bodyMedium),
          Text(
            '$mark',
            style: t.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String msg, ThemeData t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: t.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(msg, style: TextStyle(color: t.colorScheme.onErrorContainer)),
    );
  }
}
