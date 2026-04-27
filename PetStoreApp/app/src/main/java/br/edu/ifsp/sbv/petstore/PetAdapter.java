package br.edu.ifsp.sbv.petstore;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.RecyclerView;

import java.io.InputStream;
import java.net.URL;
import java.util.List;

import br.edu.ifsp.sbv.petstore.modelo.Pet;

public class PetAdapter extends RecyclerView.Adapter<PetAdapter.PetViewHolder> {

    private List<Pet> listaPets;
    private Context context;
    private OnPetClickListener listener;

    public interface OnPetClickListener {
        void onPetClick(Pet pet);
        void onPetLongClick(Pet pet);
    }

    public PetAdapter(Context context, List<Pet> listaPets, OnPetClickListener listener) {
        this.context = context;
        this.listaPets = listaPets;
        this.listener = listener;
    }

    @NonNull
    @Override
    public PetViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.item_pet, parent, false);
        return new PetViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PetViewHolder holder, int position) {
        Pet pet = listaPets.get(position);

        holder.txtNome.setText(pet.getNome());
        holder.txtCategoria.setText("Categoria: " + pet.getCategoria());
        holder.txtId.setText("ID: " + pet.getId());

        String status = pet.getStatus() != null ? pet.getStatus() : "unknown";
        holder.txtStatus.setText(traduzirStatus(status));

        int statusColor;
        switch (status.toLowerCase()) {
            case "available":
                statusColor = ContextCompat.getColor(context, R.color.status_available);
                break;
            case "pending":
                statusColor = ContextCompat.getColor(context, R.color.status_pending);
                break;
            case "sold":
                statusColor = ContextCompat.getColor(context, R.color.status_sold);
                break;
            default:
                statusColor = ContextCompat.getColor(context, R.color.status_unknown);
        }
        holder.txtStatus.setBackgroundColor(statusColor);

        holder.imgPet.setImageResource(R.drawable.ic_pet_placeholder);
        if (pet.getFotoUrl() != null && !pet.getFotoUrl().isEmpty()) {
            new DownloadImageTask(holder.imgPet).execute(pet.getFotoUrl());
        }

        holder.itemView.setOnClickListener(v -> {
            if (listener != null) listener.onPetClick(pet);
        });

        holder.itemView.setOnLongClickListener(v -> {
            if (listener != null) listener.onPetLongClick(pet);
            return true;
        });
    }

    @Override
    public int getItemCount() {
        return listaPets.size();
    }

    public void atualizarLista(List<Pet> novaLista) {
        this.listaPets = novaLista;
        notifyDataSetChanged();
    }

    private String traduzirStatus(String status) {
        switch (status.toLowerCase()) {
            case "available": return "Disponível";
            case "pending":   return "Pendente";
            case "sold":      return "Vendido";
            default:          return status;
        }
    }

    public static class PetViewHolder extends RecyclerView.ViewHolder {
        ImageView imgPet;
        TextView txtNome, txtCategoria, txtId, txtStatus;

        public PetViewHolder(@NonNull View itemView) {
            super(itemView);
            imgPet = itemView.findViewById(R.id.imgPet);
            txtNome = itemView.findViewById(R.id.txtNomePet);
            txtCategoria = itemView.findViewById(R.id.txtCategoria);
            txtId = itemView.findViewById(R.id.txtId);
            txtStatus = itemView.findViewById(R.id.txtStatus);
        }
    }

    private static class DownloadImageTask extends AsyncTask<String, Void, Bitmap> {
        ImageView imageView;

        DownloadImageTask(ImageView imageView) {
            this.imageView = imageView;
        }

        @Override
        protected Bitmap doInBackground(String... urls) {
            try {
                InputStream in = new URL(urls[0]).openStream();
                return BitmapFactory.decodeStream(in);
            } catch (Exception e) {
                return null;
            }
        }

        @Override
        protected void onPostExecute(Bitmap result) {
            if (result != null) {
                imageView.setImageBitmap(result);
            }
        }
    }
}
