public class Client {
    private int idC;
    private String nomC;
    private String prenomC;
    private int poidsC;
    private bool cotisation;


    public Client(int idC, String nomC, String prenomC, int poidsC, bool cotisation) {
        this.idC = idC;
        this.nomC = nomC;
        this.prenomC = prenomC;
        this.poidsC = poidsC;
        this.cotisation = cotisation;
    }

    public int getIdC() {
        return this.idC;
    }

    public void setIdC(int idC) {
        this.idC = idC;
    }

    public String getNomC() {
        return this.nomC;
    }

    public void setNomC(String nomC) {
        this.nomC = nomC;
    }

    public String getPrenomC() {
        return this.prenomC;
    }

    public void setPrenomC(String prenomC) {
        this.prenomC = prenomC;
    }

    public int getPoidsC() {
        return this.poidsC;
    }

    public void setPoidsC(int poidsC) {
        this.poidsC = poidsC;
    }

    public bool getCotisation() {
        return this.cotisation;
    }

    public void setCotisation(bool cotisation) {
        this.cotisation = cotisation;
    }

    @Override
    public String toString() {
        return "{" +
            " idC='" + getIdC() + "'" +
            ", nomC='" + getNomC() + "'" +
            ", prenomC='" + getPrenomC() + "'" +
            ", poidsC='" + getPoidsC() + "'" +
            ", cotisation='" + getCotisation() + "'" +
            "}";
    }

}