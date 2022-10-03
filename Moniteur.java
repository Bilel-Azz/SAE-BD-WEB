public class Moniteur {
    private int idM;
    private String nomM;
    private String prenomM;

    public Moniteur(int idM, String nomM, String prenomM) {
        this.idM = idM;
        this.nomM = nomM;
        this.prenomM = prenomM;
    }

    public int getIdM() {
        return this.idM;
    }

    public void setIdM(int idM) {
        this.idM = idM;
    }

    public String getNomM() {
        return this.nomM;
    }

    public void setNomM(String nomM) {
        this.nomM = nomM;
    }

    public String getPrenomM() {
        return this.prenomM;
    }

    public void setPrenomM(String prenomM) {
        this.prenomM = prenomM;
    }

    @Override
    public String toString() {
        return "{" +
            " idM='" + getIdM() + "'" +
            ", nomM='" + getNomM() + "'" +
            ", prenomM='" + getPrenomM() + "'" +
            "}";
    }

}
