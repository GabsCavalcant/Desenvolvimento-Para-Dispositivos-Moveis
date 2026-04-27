package br.edu.ifsp.sbv.petstore;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import br.edu.ifsp.sbv.petstore.modelo.Pet;

public class MainActivity extends AppCompatActivity implements PetAdapter.OnPetClickListener {

    private static final String TAG = "MainActivity";
    private static final String BASE_URL = "https://petstore.swagger.io/v2";

    private RecyclerView recyclerView;
    private PetAdapter adapter;
    private List<Pet> listaPets = new ArrayList<>();

    private Spinner spinnerStatus;
    private Button btnBuscar, btnAdicionarPet;
    private TextView txtContador;

    private PetDatabaseHelper dbHelper;
    private ProgressDialog progressDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        dbHelper = new PetDatabaseHelper(this);

        recyclerView = findViewById(R.id.recyclerViewPets);
        spinnerStatus = findViewById(R.id.spinnerStatus);
        btnBuscar = findViewById(R.id.btnBuscar);
        btnAdicionarPet = findViewById(R.id.btnAdicionarPet);
        txtContador = findViewById(R.id.txtContador);

        configurarSpinner();
        configurarRecyclerView();
        carregarDoBancoDeDados();

        btnBuscar.setOnClickListener(v -> buscarPetsDoWebService());
        btnAdicionarPet.setOnClickListener(v -> mostrarDialogAdicionarPet());
    }

    private void configurarSpinner() {
        String[] statusOpcoes = {"available", "pending", "sold"};
        ArrayAdapter<String> adapterSpinner = new ArrayAdapter<>(
                this, android.R.layout.simple_spinner_item, statusOpcoes);
        adapterSpinner.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerStatus.setAdapter(adapterSpinner);
    }

    private void configurarRecyclerView() {
        adapter = new PetAdapter(this, listaPets, this);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
    }

    private void carregarDoBancoDeDados() {
        List<Pet> savedPets = dbHelper.buscarTodos();
        listaPets.clear();
        listaPets.addAll(savedPets);
        adapter.atualizarLista(listaPets);
        atualizarContador();
    }

    private void atualizarContador() {
        int total = dbHelper.contarPets();
        txtContador.setText("Pets no banco local: " + total);
    }

    private void buscarPetsDoWebService() {
        String status = spinnerStatus.getSelectedItem().toString();
        new BuscarPetsTask().execute(status);
    }

    // =========== AsyncTask: Buscar Pets ===========
    private class BuscarPetsTask extends AsyncTask<String, Void, List<Pet>> {
        private String erro = null;

        @Override
        protected void onPreExecute() {
            progressDialog = ProgressDialog.show(MainActivity.this,
                    "Aguarde...", "Buscando pets no webservice...");
        }

        @Override
        protected List<Pet> doInBackground(String... params) {
            String status = params[0];
            String url = BASE_URL + "/pet/findByStatus?status=" + status;
            List<Pet> pets = new ArrayList<>();
            try {
                String json = HttpUtils.get(url);
                JSONArray jsonArray = new JSONArray(json);
                for (int i = 0; i < Math.min(jsonArray.length(), 30); i++) {
                    try {
                        Pet pet = new Pet(jsonArray.getJSONObject(i));
                        if (pet.getNome() != null && !pet.getNome().isEmpty()) {
                            pets.add(pet);
                            dbHelper.inserirOuAtualizar(pet);
                        }
                    } catch (Exception e) {
                        Log.w(TAG, "Erro ao parsear pet " + i + ": " + e.getMessage());
                    }
                }
            } catch (Exception e) {
                Log.e(TAG, "Erro na requisição: ", e);
                erro = e.getMessage();
            }
            return pets;
        }

        @Override
        protected void onPostExecute(List<Pet> pets) {
            progressDialog.dismiss();
            if (erro != null) {
                Toast.makeText(MainActivity.this,
                        "Erro ao buscar dados: " + erro, Toast.LENGTH_LONG).show();
                carregarDoBancoDeDados();
            } else {
                listaPets.clear();
                listaPets.addAll(pets);
                adapter.atualizarLista(listaPets);
                atualizarContador();
                Toast.makeText(MainActivity.this,
                        pets.size() + " pets encontrados e salvos!", Toast.LENGTH_SHORT).show();
            }
        }
    }

    // =========== AsyncTask: Adicionar Pet ===========
    private void mostrarDialogAdicionarPet() {
        View dialogView = getLayoutInflater().inflate(R.layout.dialog_adicionar_pet, null);
        EditText edNome = dialogView.findViewById(R.id.edNomePet);
        EditText edCategoria = dialogView.findViewById(R.id.edCategoria);
        Spinner spinnerStatusDialog = dialogView.findViewById(R.id.spinnerStatusDialog);

        String[] statusOpcoes = {"available", "pending", "sold"};
        ArrayAdapter<String> adapterSpinner = new ArrayAdapter<>(
                this, android.R.layout.simple_spinner_item, statusOpcoes);
        adapterSpinner.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerStatusDialog.setAdapter(adapterSpinner);

        new AlertDialog.Builder(this)
                .setTitle("Adicionar Novo Pet")
                .setView(dialogView)
                .setPositiveButton("Salvar", (dialog, which) -> {
                    String nome = edNome.getText().toString().trim();
                    String categoria = edCategoria.getText().toString().trim();
                    String status = spinnerStatusDialog.getSelectedItem().toString();

                    if (nome.isEmpty()) {
                        Toast.makeText(this, "Nome é obrigatório!", Toast.LENGTH_SHORT).show();
                        return;
                    }
                    new AdicionarPetTask().execute(nome, categoria, status);
                })
                .setNegativeButton("Cancelar", null)
                .show();
    }

    private class AdicionarPetTask extends AsyncTask<String, Void, Pet> {
        private String erro = null;

        @Override
        protected void onPreExecute() {
            progressDialog = ProgressDialog.show(MainActivity.this,
                    "Aguarde...", "Cadastrando pet...");
        }

        @Override
        protected Pet doInBackground(String... params) {
            String nome = params[0];
            String categoria = params.length > 1 ? params[1] : "Geral";
            String status = params.length > 2 ? params[2] : "available";

            try {
                JSONObject body = new JSONObject();
                body.put("name", nome);
                body.put("status", status);

                JSONObject cat = new JSONObject();
                cat.put("id", 0);
                cat.put("name", categoria.isEmpty() ? "Geral" : categoria);
                body.put("category", cat);

                body.put("photoUrls", new org.json.JSONArray());
                body.put("tags", new org.json.JSONArray());

                String resposta = HttpUtils.post(BASE_URL + "/pet", body.toString());
                JSONObject jsonResposta = new JSONObject(resposta);
                Pet novoPet = new Pet(jsonResposta);
                dbHelper.inserirOuAtualizar(novoPet);
                return novoPet;
            } catch (Exception e) {
                Log.e(TAG, "Erro ao adicionar pet: ", e);
                erro = e.getMessage();
                return null;
            }
        }

        @Override
        protected void onPostExecute(Pet pet) {
            progressDialog.dismiss();
            if (pet != null) {
                listaPets.add(0, pet);
                adapter.atualizarLista(listaPets);
                atualizarContador();
                Toast.makeText(MainActivity.this,
                        "Pet '" + pet.getNome() + "' cadastrado com sucesso! ID: " + pet.getId(),
                        Toast.LENGTH_LONG).show();
            } else {
                Toast.makeText(MainActivity.this,
                        "Erro ao cadastrar: " + erro, Toast.LENGTH_LONG).show();
            }
        }
    }

    // =========== Clique nos itens ===========
    @Override
    public void onPetClick(Pet pet) {
        new AlertDialog.Builder(this)
                .setTitle("🐾 " + pet.getNome())
                .setMessage(
                        "ID: " + pet.getId() + "\n" +
                        "Categoria: " + pet.getCategoria() + "\n" +
                        "Status: " + traduzirStatus(pet.getStatus()) + "\n" +
                        (pet.getFotoUrl() != null ? "Foto disponível ✓" : "Sem foto")
                )
                .setPositiveButton("OK", null)
                .show();
    }

    @Override
    public void onPetLongClick(Pet pet) {
        new AlertDialog.Builder(this)
                .setTitle("Remover Pet")
                .setMessage("Deseja remover \"" + pet.getNome() + "\" do banco local?")
                .setPositiveButton("Remover", (dialog, which) -> {
                    dbHelper.excluir(pet.getId());
                    listaPets.remove(pet);
                    adapter.atualizarLista(listaPets);
                    atualizarContador();
                    Toast.makeText(this, "Pet removido do banco local.", Toast.LENGTH_SHORT).show();
                })
                .setNegativeButton("Cancelar", null)
                .show();
    }

    private String traduzirStatus(String status) {
        if (status == null) return "Desconhecido";
        switch (status.toLowerCase()) {
            case "available": return "Disponível";
            case "pending":   return "Pendente";
            case "sold":      return "Vendido";
            default:          return status;
        }
    }
}
