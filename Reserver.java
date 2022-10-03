public class Reserver {

    private int idC;
    private int idPo;
    private int idCour;

    public Reserver(int idC, int idPo, int idCour) {
        this.idC = idC;
        this.idPo = idPo;
        this.idCour = idCour;
    }

    public int getIdC() {
        return this.idC;
    }

    public void setIdC(int idC) {
        this.idC = idC;
    }

    public int getIdPo() {
        return this.idPo;
    }

    public void setIdPo(int idPo) {
        this.idPo = idPo;
    }

    public int getIdCour() {
        return this.idCour;
    }

    public void setIdCour(int idCour) {
        this.idCour = idCour;
    }


    @Override
    public String toString() {
        return "{" +
            " idC='" + getIdC() + "'" +
            ", idPo='" + getIdPo() + "'" +
            ", idCour='" + getIdCour() + "'" +
            "}";
    }
    
}
