public class Poney {
    private int idPo;
    private String nomPo;
    private int agePo;
    private int poidPo;
    private int poidSup ;

    public Poney(int idPo, String nomPo, int agePo, int poidPo, int poidSup) {
        this.idPo = idPo;
        this.nomPo = nomPo;
        this.agePo = agePo;
        this.poidPo = poidPo;
        this.poidSup = poidSup;
    }


    public int getIdPo() {
        return this.idPo;
    }

    public void setIdPo(int idPo) {
        this.idPo = idPo;
    }

    public String getNomPo() {
        return this.nomPo;
    }

    public void setNomPo(String nomPo) {
        this.nomPo = nomPo;
    }

    public int getAgePo() {
        return this.agePo;
    }

    public void setAgePo(int agePo) {
        this.agePo = agePo;
    }

    public int getPoidPo() {
        return this.poidPo;
    }

    public void setPoidPo(int poidPo) {
        this.poidPo = poidPo;
    }

    public int getPoidSup() {
        return this.poidSup;
    }

    public void setPoidSup(int poidSup) {
        this.poidSup = poidSup;
    }

    @Override
    public String toString() {
        return "{" +
            " idPo='" + getIdPo() + "'" +
            ", nomPo='" + getNomPo() + "'" +
            ", agePo='" + getAgePo() + "'" +
            ", poidPo='" + getPoidPo() + "'" +
            ", poidSup='" + getPoidSup() + "'" +
            "}";
    }

}
