package br.edu.ifsp.sbv.petstore;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

import br.edu.ifsp.sbv.petstore.modelo.Pet;

public class PetDatabaseHelper extends SQLiteOpenHelper {

    private static final String DATABASE_NAME = "petstore.db";
    private static final int DATABASE_VERSION = 1;

    public static final String TABLE_PETS = "pets";
    public static final String COL_ID = "id";
    public static final String COL_NOME = "nome";
    public static final String COL_STATUS = "status";
    public static final String COL_CATEGORIA = "categoria";
    public static final String COL_FOTO_URL = "foto_url";

    private static final String CREATE_TABLE =
            "CREATE TABLE " + TABLE_PETS + " (" +
            COL_ID + " INTEGER PRIMARY KEY, " +
            COL_NOME + " TEXT NOT NULL, " +
            COL_STATUS + " TEXT, " +
            COL_CATEGORIA + " TEXT, " +
            COL_FOTO_URL + " TEXT" +
            ")";

    public PetDatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(CREATE_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_PETS);
        onCreate(db);
    }

    public long inserirOuAtualizar(Pet pet) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(COL_ID, pet.getId());
        values.put(COL_NOME, pet.getNome());
        values.put(COL_STATUS, pet.getStatus());
        values.put(COL_CATEGORIA, pet.getCategoria());
        values.put(COL_FOTO_URL, pet.getFotoUrl());

        long result = db.insertWithOnConflict(TABLE_PETS, null, values, SQLiteDatabase.CONFLICT_REPLACE);
        db.close();
        return result;
    }

    public List<Pet> buscarTodos() {
        List<Pet> lista = new ArrayList<>();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.query(TABLE_PETS, null, null, null, null, null, COL_NOME + " ASC");

        if (cursor.moveToFirst()) {
            do {
                Pet pet = cursorParaPet(cursor);
                lista.add(pet);
            } while (cursor.moveToNext());
        }
        cursor.close();
        db.close();
        return lista;
    }

    public List<Pet> buscarPorStatus(String status) {
        List<Pet> lista = new ArrayList<>();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.query(TABLE_PETS, null,
                COL_STATUS + " = ?", new String[]{status},
                null, null, COL_NOME + " ASC");

        if (cursor.moveToFirst()) {
            do {
                lista.add(cursorParaPet(cursor));
            } while (cursor.moveToNext());
        }
        cursor.close();
        db.close();
        return lista;
    }

    public Pet buscarPorId(long id) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.query(TABLE_PETS, null,
                COL_ID + " = ?", new String[]{String.valueOf(id)},
                null, null, null);

        Pet pet = null;
        if (cursor.moveToFirst()) {
            pet = cursorParaPet(cursor);
        }
        cursor.close();
        db.close();
        return pet;
    }

    public int excluir(long id) {
        SQLiteDatabase db = this.getWritableDatabase();
        int rows = db.delete(TABLE_PETS, COL_ID + " = ?", new String[]{String.valueOf(id)});
        db.close();
        return rows;
    }

    public int contarPets() {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT COUNT(*) FROM " + TABLE_PETS, null);
        int count = 0;
        if (cursor.moveToFirst()) count = cursor.getInt(0);
        cursor.close();
        db.close();
        return count;
    }

    private Pet cursorParaPet(Cursor cursor) {
        Pet pet = new Pet();
        pet.setId(cursor.getLong(cursor.getColumnIndexOrThrow(COL_ID)));
        pet.setNome(cursor.getString(cursor.getColumnIndexOrThrow(COL_NOME)));
        pet.setStatus(cursor.getString(cursor.getColumnIndexOrThrow(COL_STATUS)));
        pet.setCategoria(cursor.getString(cursor.getColumnIndexOrThrow(COL_CATEGORIA)));
        pet.setFotoUrl(cursor.getString(cursor.getColumnIndexOrThrow(COL_FOTO_URL)));
        return pet;
    }
}
