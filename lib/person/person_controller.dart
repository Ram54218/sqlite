import 'package:sqflite/sqflite.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqlite/app_constant/app_constant.dart';
import 'package:sqlite/app_model/app_model.dart';
import 'package:sqlite/database/database_helper.dart';

class PersonController {
  // retrieve the person list
  getPersonDetail() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>>? data =
        await db.query(DatabaseHelper.officeTableName);
    return List.generate(data!.length, (i) {
      return PersonDetail(
          id: data[i]['id'],
          name: data[i]['name'],
          gender: data[i]['gender'],
          address: data[i]['address'],
          dob: data[i]['dob'],
          emailAddress: data[i]['emailAddress'],
          mobileNumber: data[i]['mobileNumber'],
          state: data[i]['state'],
          district: data[i]['district']);
    });
  }

// add the person
  addPersonDetails(PersonDetail personDetail) async {
    final db = await DatabaseHelper.database;
    return await db?.insert(
      DatabaseHelper.officeTableName,
      personDetail.mapPersonDetail(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Encryption and Decryption data
  encryption(String data, bool isEncryption) {
    final key = encrypt.Key.fromUtf8(AppConstant.encryptionKey);
    final iv = encrypt.IV.fromUtf8(AppConstant.encryptionIv);
    final encryptType =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ctr));
    if (isEncryption) {
      final encrypted = encryptType.encrypt(data, iv: iv);
      return encrypted.base64;
    } else {
      final decrypted =
          encryptType.decrypt(encrypt.Encrypted.fromBase64(data), iv: iv);
      return decrypted;
    }
  }

  // update the person
  updatePerson(PersonDetail personDetail) async {
    final db = DatabaseHelper.database;
    return await db!.update(
        DatabaseHelper.officeTableName, personDetail.mapPersonDetail(),
        where: 'id=?', whereArgs: [personDetail.id]);
  }

  //delete the person
  deletePerson(int id) async {
    final db = DatabaseHelper.database;
    return await db!.rawDelete(
        "delete from ${DatabaseHelper.officeTableName} where id = $id");
  }
}
