import 'package:darto/darto.dart';
import 'package:darto_tutorial/router.dart';

void main() {
  final darto = Darto();

  darto.use('/api/v1', rootRouter());

  darto.listen(3000, () {
    print('API com Darto rodando na porta 3000');
  });
}
