package br.edu.ifsp.sbv.exemplolistview;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import br.edu.ifsp.sbv.exemplolistview.modelo.Pessoa;
import br.edu.ifsp.sbv.exemplolistview.modelo.Produto;


public class MainActivity extends AppCompatActivity {

    private Produto p;
    private List<Produto> produtos;
    private EditText edDescricao;
    private EditText edId;

    private EditText edValor;

    private ListView lvProdutos;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        edId = (EditText) findViewById(R.id.edID);
        edDescricao = (EditText) findViewById(R.id.edDescricao);
        edValor = (EditText) findViewById(R.id.edNumber);


        double editValor = Double.parseDouble(edValor.getText().toString());

        lvProdutos = (ListView) findViewById(R.id.lvProdutos);
        lvProdutos.setOnItemClickListener(selecionarPessoa);
        produtos = new ArrayList<Produto>();

    }



    public void salvar(View v) {
        p = new Produto();
        p.setId(Integer.parseInt(edId.getText().toString()));
        p.setDescricao(edDescricao.getText().toString());
        p.setValor(Double.parseDouble(edValor.getText().toString()));
        produtos.add(p);
        atulizarLista();
        limparDados();
        exibirMensagem("Pessoa cadastrada com sucesso!");

    }

    private void limparDados() {
        edId.setText("");
        edId.requestFocus();
        edDescricao.setText("");
        edValor.setText("");
    }

    private void atulizarLista() {
        PessoaListAdapter pla = new PessoaListAdapter(getApplicationContext(),
                produtos);
        lvProdutos.setAdapter(pla);

    }

    private AdapterView.OnItemClickListener selecionarPessoa = new AdapterView.OnItemClickListener() {

        public void onItemClick(AdapterView<?> arg0, View arg1, int pos, long id) {
            Pessoa pessoa = produtos.get(pos);
            preecherDados(produto);

        }

        private void preecherDados(Pessoa pessoa) {
            edNome.setText(pessoa.getNome());
            edIdade.setText(String.valueOf(pessoa.getIdade()));

        }

    };

    private void exibirMensagem(String msg) {
        Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_LONG).show();
    }
}