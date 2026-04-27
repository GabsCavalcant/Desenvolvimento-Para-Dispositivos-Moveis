package br.edu.ifsp.sbv.petstore.modelo;

import org.json.JSONException;
import org.json.JSONObject;

public class Pet {

    private long id;
    private String nome;
    private String status;
    private String categoria;
    private String fotoUrl;

    public Pet() {}

    public Pet(JSONObject json) throws JSONException {
        this.id = json.optLong("id", 0);
        this.nome = json.optString("name", "Sem nome");
        this.status = json.optString("status", "unknown");

        if (json.has("category") && !json.isNull("category")) {
            JSONObject cat = json.getJSONObject("category");
            this.categoria = cat.optString("name", "Sem categoria");
        } else {
            this.categoria = "Sem categoria";
        }

        if (json.has("photoUrls")) {
            org.json.JSONArray photos = json.getJSONArray("photoUrls");
            if (photos.length() > 0 && !photos.getString(0).isEmpty()) {
                this.fotoUrl = photos.getString(0);
            }
        }
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getFotoUrl() { return fotoUrl; }
    public void setFotoUrl(String fotoUrl) { this.fotoUrl = fotoUrl; }

    @Override
    public String toString() {
        return "Pet{id=" + id + ", nome='" + nome + "', status='" + status + "', categoria='" + categoria + "'}";
    }
}
