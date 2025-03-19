import 'package:app_provider/model/contatos.dart';
import 'package:sqflite/sqflite.dart';

class Appdatabase {
  static Future<Database>? database;

  static Future<void> create() async {
    
    database = openDatabase(
      "${await getDatabasesPath()}.com.app",
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE contatos(nome TEXT,telefone TEXT, foto TEXT)',
        );
      },
      onUpgrade: ((db, oldVersion, newVersion) {
        // if (oldVersion < 2) {
        //   db.execute(
        //     'CREATE TABLE zones(id INTEGER INTEGER, name TEXT, inventary_id INTEGER, PRIMARY KEY (id, inventary_id))',
        //   );          
        // }
      }),
      version: 1,
    );
  }

  static Future<void> insertContato(Contato contato) async {
    final db = await Appdatabase.database;
    await db?.insert(
      'contatos',
      contato.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Contato>> getContatos() async {
          
    final db = await Appdatabase.database;   
    final List<Map<String, dynamic>> maps =
        await db!.rawQuery('SELECT * FROM contatos ');
    var listContatos = List.generate(maps.length, (i) {
      return Contato.fromJson(maps[i]);
    });

    return listContatos;  
  }

  static Future<void> addListProduto(List<Contato> contatos) async {
    final db = await Appdatabase.database;

    ///Inserir 10.000 por vez pra não dar erro de memória
    await db?.transaction((txn) async {
      var batch = txn.batch();
      var sublist = <Contato>[];
      if (contatos.length > 10000) {
        sublist = contatos.getRange(0, 10000).toList();
      } else {
        sublist = contatos;
      }
      for (var e in sublist) {
        batch.insert("produto", e.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(continueOnError: true, noResult: true);
    }).then((_) {
      if (contatos.length > 10000) {
        Appdatabase.addListProduto(contatos.getRange(10001, contatos.length).toList());
      }
    });
  }
}
