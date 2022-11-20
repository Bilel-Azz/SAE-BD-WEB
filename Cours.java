import java.sql.Date;
import java.sql.Time;

public class Cours {
    private int idCour;
    private String nomCour;
    private int idM;
    private Date dateCour;
    private Time heure;
    private Time duree;
    private String dateCour2;
    private String heure2;
    private String duree2;


    public Cours(int idCour, String nomCour, int idM, Date dateCour, Time heure, Time duree) {
        this.idCour = idCour;
        this.nomCour = nomCour;
        this.idM = idM;
        this.dateCour = dateCour;
        this.heure = heure;
        this.duree = duree;
    }

    public Cours(int idCour, String nomCour, int idM, String dateCour2, String heure2, String duree2) {
        this.idCour = idCour;
        this.nomCour = nomCour;
        this.idM = idM;
        this.dateCour2 = dateCour2;
        this.heure2 = heure2;
        this.duree2 = duree2;
    }
    

    public int getIdCour() {
        return this.idCour;
    }

    public void setIdCour(int idCour) {
        this.idCour = idCour;
    }

    public String getNomCour() {
        return this.nomCour;
    }

    public void setNomCour(String nomCour) {
        this.nomCour = nomCour;
    }

    public int getIdM() {
        return this.idM;
    }

    public void setIdM(int idM) {
        this.idM = idM;
    }

    public Date getDateCour() {
        return this.dateCour;
    }

    public String getDateCoursString() {
        return this.dateCour2;
    }


    public void setDateCour(Date dateCour) {
        this.dateCour = dateCour;
    }

    public Time getHeure() {
        return this.heure;
    }

    public String getHeureString() {
        return this.heure2;
    }

    public void setHeure(Time heure) {
        this.heure = heure;
    }

    public Time getDuree() {
        return this.duree;
    }

    public String getDureeString() {
        return this.duree2;
    }

    public void setDuree(Time duree) {
        this.duree = duree;
    }

    @Override
    public String toString() {
        return "{" +
            " idCour='" + getIdCour() + "'" +
            ", nomCour='" + getNomCour() + "'" +
            ", idM='" + getIdM() + "'" +
            ", dateCour='" + getDateCour() + "'" +
            ", heure='" + getHeure() + "'" +
            ", duree='" + getDuree() + "'" +
            "}";
    }


}
