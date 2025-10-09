library demo_dart_vs_java;

import 'package:flutter/material.dart';

// ======================== Funcions top-level DEMO (fora de classes) ========================
int sum(int a, int b) => a + b; // 3. Funcions fora de classes — lambda curta
List<String> constReturn() => const ['immutable', 'list']; // 6. const al retorn
int add({int a = 1, int b = 2}) => a + b; // 7. defaults + named params
String formatUser({required String name, int id = 0}) => '[$id] $name'; // 8/15. named
String greet(String name, [String suffix = '!']) => 'Hola $name$suffix'; // 9. opcionals []
String runWithOp(int x, int y, String Function(int, int) op) => op(x, y); // 10/17/18
T echo<T>(T value) => value; // 19. Genèrics
List<T> wrap<T>(T value) => <T>[value]; // 19.

void main() => runApp(const DemoApp()); // 5/13. Sense `new` + const per rendiment

class DemoApp extends StatelessWidget {
  const DemoApp({super.key}); // 16. Constructor sense cos si només inicialitza
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart vs Java — Demos',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

// ======================== UNA SOLA CLASSE DE PANTALLA ========================
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart vs Java — Exemples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          cardLibrary(),
          cardTypeInference(),
          cardTopLevelFunctions(),
          cardConstructorsSenseClaus(),
          cardNoNew(),
          cardConstReturn(),
          cardDefaultParams(),
          cardNamedUnordered(),
          cardOptionals(),
          cardFunctionTypeParams(),
          cardNamedConstructors(),
          cardPrivateWithUnderscore(),
          cardConstPerformance(),
          cardInitializerList(),
          cardNamedParamsColonSyntax(),
          cardConstructorsSenseCodi(),
          cardLambdaDeclaration(),
          cardLambdaPassing(),
          cardGenerics(),
        ],
      ),
    );
  }
}

// ======================== HELPERS (funcions que creen widgets) ========================
Widget exampleCard({required int number, required String title, required Widget child}) {
  return Card(
    elevation: 1,
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number. $title', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    ),
  );
}

Widget codeText(String text) => SelectableText(text);

// ======================== 1..19 Targetes (funcions widgets) ========================
Widget cardLibrary() => exampleCard(
      number: 1,
      title: 'library en comptes de package',
      child: codeText('A dalt del fitxer: `library demo_dart_vs_java;` (opcional en Dart).'),
    );

Widget cardTypeInference() {
  final x = sum(2, 3);
  final list = constReturn();
  return exampleCard(
    number: 2,
    title: 'Inferència de tipus',
    child: codeText('final x = sum(2,3) → $x final list = constReturn() → $list'),
  );
}

Widget cardTopLevelFunctions() => exampleCard(
      number: 3,
      title: 'Funcions fora de classes',
      child: codeText('sum(), constReturn(), greet() estan definides a nivell global (no dins d\'una classe).'),
    );

Widget cardConstructorsSenseClaus() {
  final p = Person('Ada', age: 23);
  return exampleCard(
    number: 4,
    title: 'Constructors sense claus',
    child: codeText('class Person { Person(this.name, {this.age=0}); }Person("Ada", age:23) → ${p.name} (${p.age})'),
  );
}

Widget cardNoNew() => exampleCard(
      number: 5,
      title: 'No es fa servir la paraula clau `new`',
      child: codeText('Ex.: runApp(const DemoApp()); i Widget() en lloc de new Widget().'),
    );

Widget cardConstReturn() {
  final r = constReturn();
  return exampleCard(
    number: 6,
    title: '`const` al retorn de les funcions',
    child: codeText('constReturn() → $r (llista inmutable en temps de compilació).'),
  );
}

Widget cardDefaultParams() {
  final d1 = add();
  final d2 = add(a: 5, b: 10);
  return exampleCard(
    number: 7,
    title: 'Paràmetres amb valors per defecte',
    child: codeText('add() → $d1 (usa a=1,b=2)add(a:5,b:10) → $d2'),
  );
}

Widget cardNamedUnordered() {
  final f1 = formatUser(name: 'Ramon', id: 22);
  final f2 = formatUser(id: 7, name: 'Ada');
  return exampleCard(
    number: 8,
    title: 'Paràmetres desordenats amb nom (named params)',
    child: codeText('formatUser(name:"Ramon", id:22) → $f1 formatUser(id:7, name:"Ada") → $f2'),
  );
}

Widget cardOptionals() {
  final g1 = greet('Ramon');
  final g2 = greet('Ramon', ' 🙂');
  return exampleCard(
    number: 9,
    title: 'Paràmetres opcionals — {} per named, [] per posicionals',
    child: codeText('Named opcionals: formatUser({id=0})Posicionals opcionals: greet("Ramon", [suffix]) → $g1 / $g2'),
  );
}

Widget cardFunctionTypeParams() {
  String Function(int, int) joinInts = (a, b) => '$a-$b';
  final joined = runWithOp(7, 9, (x, y) => '$x+$y=${x + y}');
  return exampleCard(
    number: 10,
    title: 'Paràmetres de tipus funció',
    child: codeText('String Function(int,int) f; joinInts(1,2) → ${joinInts(1, 2)}runWithOp(7,9,(x,y)=>...) → $joined Literal com a text: "String Function(int,int) nomParam"'),
  );
}

Widget cardNamedConstructors() {
  final p1 = Person('Sara');
  final p2 = Person.guest();
  return exampleCard(
    number: 11,
    title: 'Named constructors',
    child: codeText('Person("Sara") → ${p1.name}Person.guest() → ${p2.name}'),
  );
}

Widget cardPrivateWithUnderscore() {
  const secret = _Secret('token-xyz');
  return exampleCard(
    number: 12,
    title: 'Guió baix (_) implica classe privada a la llibreria',
    child: codeText('_Secret només és visible dins aquest fitxer. masked() → ${secret.masked()}'),
  );
}

Widget cardConstPerformance() => exampleCard(
      number: 13,
      title: '`const` per millorar el rendiment',
      child: codeText('Fer widgets i dades `const` (p.ex. const Text("...")) permet reutilitzar instàncies i evitar rebuilds.'),
    );

Widget cardInitializerList() {
  final pt = Point(2, 4);
  return exampleCard(
    number: 14,
    title: 'Llista d\'inicialització (dos punts després del constructor)',
    child: codeText('class Point { final int x; final int y; Point(this.x, this.y) : assert(x>=0 && y>=0); }Point(2,4) → (${pt.x}, ${pt.y})'),
  );
}

Widget cardNamedParamsColonSyntax() => exampleCard(
      number: 15,
      title: 'Named params es passen amb dos punts',
      child: codeText('Ex.: formatUser(name: "Ada", id: 7) — sintaxi param: valor.'),
    );

Widget cardConstructorsSenseCodi() {
  final s = Simple(5);
  return exampleCard(
    number: 16,
    title: 'Constructors sense codi si inicialitzen bàsics',
    child: codeText('class Simple { final int x; Simple(this.x); } → Simple(5).x = ${s.x}'),
  );
}

Widget cardLambdaDeclaration() {
  String Function(int, int) fmt = (a, b) => '$a:$b';
  return exampleCard(
    number: 17,
    title: 'Declaració de lambdes',
    child: codeText('String Function(int,int) fmt = (a,b)=>"\$a:\$b" → fmt(3,4) = ${fmt(3, 4)}'),
  );
}

Widget cardLambdaPassing() {
  final r = runWithOp(3, 5, (x, y) => 'suma=${x + y}');
  return exampleCard(
    number: 18,
    title: 'Pas de lambdes',
    child: codeText('runWithOp(3,5,(x,y)=>"suma=\${x+y}") → $r'),
  );
}

Widget cardGenerics() {
  final e = echo<num>(3.14);
  final w = wrap<String>('tag');
  return exampleCard(
    number: 19,
    title: 'Genèrics <T> (paràmetre vs retorn)',
    child: codeText('echo<num>(3.14) → $e wrap<String>("tag") → $w'),
  );
}

// ======================== Models ========================
class Person {
  final String name;
  final int age;
  Person(this.name, {this.age = 0}); // 4/16
  Person.guest()
      : name = 'Guest',
        age = 0; // 11/14 — llista d'inicialització
}

class Point {
  final int x;
  final int y;
  // 14. Llista d'inicialització + assert
  Point(this.x, this.y) : assert(x >= 0 && y >= 0, 'Coordenades no negatives');
}

class Simple {
  final int x;
  Simple(this.x); // 16. Constructor sense cos
}

// 12. Classe privada (guió baix)
class _Secret {
  final String value;
  const _Secret(this.value);
  String masked() => value.replaceRange(3, value.length, '***');
}
