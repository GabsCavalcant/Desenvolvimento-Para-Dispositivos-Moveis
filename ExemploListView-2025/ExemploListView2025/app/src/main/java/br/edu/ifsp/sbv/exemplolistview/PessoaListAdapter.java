package br.edu.ifsp.sbv.exemplolistview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.List;

import br.edu.ifsp.sbv.exemplolistview.modelo.Pessoa;


public class PessoaListAdapter extends BaseAdapter {

	private Context context;
	private List<Pessoa> lista;

	public PessoaListAdapter(Context context, List<Pessoa> lista) {
		this.context = context;
		this.lista = lista;
	}

	public int getCount() {
		return lista.size();
	}

	public Object getItem(int position) {
		return lista.get(position);
	}

	public long getItemId(int position) {
		return position;
	}

	public View getView(int position, View convertView, ViewGroup parent) {
		Pessoa p = lista.get(position);
		LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View view = inflater.inflate(R.layout.produtos, null);
		
		TextView nome = (TextView) view.findViewById(R.id.txIdPessoa);
		nome.setText(p.getNome());
		
		TextView idade = (TextView) view.findViewById(R.id.txtDescProduto);
		idade.setText(String.valueOf(p.getIdade()));

		return view;
	}
}