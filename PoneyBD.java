import java.sql.*;
import java.util.ArrayList;

public class PoneyBD {
    private ConnexionMySQL co;

    public PoneyBD(ConnexionMySQL co) {
        this.co = co;
    }

    public void insertPoney(Poney p) {
        try {
            String query = "INSERT INTO PONEY (idPo, nomPo, agePo, poidPo, poidSup) VALUES (?,?,?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, p.getIdPo());
            ps.setString(2, p.getNomPo());
            ps.setInt(3, p.getAgePo());
            ps.setInt(4, p.getPoidPo());
            ps.setInt(5, p.getPoidSup());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertClient(Client c) {
        try {
            String query = "INSERT INTO CLIENT (idC, nomC, prenomC, poidsC, cotisation) VALUES (?,?,?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, c.getIdC());
            ps.setString(2, c.getNomC());
            ps.setString(3, c.getPrenomC());
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertMoniteur(Moniteur m) {
        try {
            String query = "INSERT INTO MONITEUR (idM, nomM, prenomM) VALUES (?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, m.getIdM());
            ps.setString(2, m.getNomM());
            ps.setString(3, m.getPrenomM());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertCours(Cours c) {
        try {
            String query = "INSERT INTO COURS (idCour, nomCour, idM, datee, heure, duree) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, c.getIdCour());
            ps.setString(2, c.getNomCour());
            ps.setInt(3, c.getIdM());
            ps.setDate(4, c.getDateCour());
            ps.setTime(5, c.getHeure());
            ps.setTime(6, c.getDuree());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertReserver(Reserver r) {
        try {
            String query = "INSERT INTO RESERVER (idC, idCour,idPo) VALUES (?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, r.getIdC());
            ps.setInt(2, r.getIdCour());
            ps.setInt(3, r.getIdPo());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Client getClient(int id ){
        Client c = null;
        try {
            String query = "SELECT * FROM CLIENT WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                c = new Client(rs.getInt("idC"), rs.getString("nomC"), rs.getString("prenomC"), rs.getInt("poidsC"), rs.getBoolean("cotisation"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public Poney getPoney(int id ){
        Poney p = null;
        try {
            String query = "SELECT * FROM PONEY WHERE idPo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                p = new Poney(rs.getInt("idPo"), rs.getString("nomPo"), rs.getInt("agePo"), rs.getInt("poidPo"), rs.getInt("poidSup"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }
    
    public Moniteur getMoniteur(int id ){
        Moniteur m = null;
        try {
            String query = "SELECT * FROM Moniteur WHERE idM = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                m = new Moniteur(rs.getInt("idM"), rs.getString("nomM"), rs.getString("prenomM"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return m;
    }

    public Cours getCours(int id ){
        Cours c = null;
        try {
            String query = "SELECT * FROM COURS WHERE idCo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                c = new Cours(rs.getInt("idCour"), rs.getString("nomCour"), rs.getInt("idM"), rs.getDate("datee"), rs.getTime("heure"), rs.getTime("duree"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public Reserver getReserver(int id ){
        Reserver r = null;
        try {
            String query = "SELECT * FROM RESERVER WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                r = new Reserver(rs.getInt("idC"), rs.getInt("idCour"), rs.getInt("idPo"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }

    public void suppresseClient(int id ){
        try {
            String query = "DELETE FROM Client WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
   
   public ArrayList<Poney> getAllPoney() {
         ArrayList<Poney> poneys = new ArrayList<Poney>();
         try {
              String query = "SELECT * FROM PONEY";
              PreparedStatement ps = co.getConnexion().prepareStatement(query);
              ResultSet rs = ps.executeQuery();
              while(rs.next()){
                poneys.add(new Poney(rs.getInt("idPo"), rs.getString("nomPo"), rs.getInt("agePo"), rs.getInt("poidPo"), rs.getInt("poidSup")));
              }
         } catch (SQLException e) {
              e.printStackTrace();
         }
         return poneys;
    }

    public ArrayList<Moniteur> getAllMoniteur() {
         ArrayList<Moniteur> moniteurs = new ArrayList<Moniteur>();
         try {
              String query = "SELECT * FROM MONITEUR";
              PreparedStatement ps = co.getConnexion().prepareStatement(query);
              ResultSet rs = ps.executeQuery();
              while(rs.next()){
                moniteurs.add(new Moniteur(rs.getInt("idM"), rs.getString("nomM"), rs.getString("prenomM")));
              }
         } catch (SQLException e) {
              e.printStackTrace();
         }
         return moniteurs;
    }

    public ArrayList<Client> getAllClient() {
        ArrayList<Client> clients = new ArrayList<Client>();
        try {
            String query = "SELECT * FROM CLIENT";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                clients.add(new Client(rs.getInt("idC"), rs.getString("nomC"), rs.getString("prenomC"), rs.getInt("poidsC"), rs.getBoolean("cotisation")));
            }
         }catch (SQLException e) {
            e.printStackTrace();
        }
        return clients;
    }

    public ArrayList<Cours> getAllCours() {
         ArrayList<Cours> cours = new ArrayList<Cours>();
         try {
              String query = "SELECT * FROM COURS";
              PreparedStatement ps = co.getConnexion().prepareStatement(query);
              ResultSet rs = ps.executeQuery();
              while(rs.next()){
                cours.add(new Cours(rs.getInt("idCour"), rs.getString("nomCour"), rs.getInt("idM"), rs.getDate("dates"), rs.getTime("heure"), rs.getTime("duree")));
              }
         } catch (SQLException e) {
              e.printStackTrace();
         }
         return cours;
    }

    public ArrayList<Reserver> getAllReserver() {
         ArrayList<Reserver> reserver = new ArrayList<Reserver>();
         try {
              String query = "SELECT * FROM RESERVER";
              PreparedStatement ps = co.getConnexion().prepareStatement(query);
              ResultSet rs = ps.executeQuery();
              while(rs.next()){
                reserver.add(new Reserver(rs.getInt("idC"), rs.getInt("idCour"), rs.getInt("idPo")));
              }
         } catch (SQLException e) {
              e.printStackTrace();
         }
         return reserver;
    }

    public void updateClient(Client c){
        try {
            String query = "UPDATE CLIENT SET nomC = ?, prenomC = ?, poidsC = ?, cotisation = ? WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setString(1, c.getNomC());
            ps.setString(2, c.getPrenomC());
            ps.setInt(3, c.getPoidsC());
            ps.setBoolean(4, c.getCotisation());
            ps.setInt(5, c.getIdC());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void updatePoney(Poney p){
        try {
            String query = "UPDATE PONEY SET nomPo = ?, agePo = ?, poidPo = ?, poidSup = ? WHERE idPo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setString(1, p.getNomPo());
            ps.setInt(2, p.getAgePo());
            ps.setInt(3, p.getPoidPo());
            ps.setInt(4, p.getPoidSup());
            ps.setInt(5, p.getIdPo());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void deletePoney(int id){
        try {
            String query = "DELETE FROM PONEY WHERE idPo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateReserver(Reserver r){
        try {
            String query = "UPDATE RESERVER SET idC = ?, idCour = ?, idPo = ? WHERE idC = ? AND idCour = ? AND idPo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, r.getIdC());
            ps.setInt(2, r.getIdCour());
            ps.setInt(3, r.getIdPo());
            ps.setInt(4, r.getIdC());
            ps.setInt(5, r.getIdCour());
            ps.setInt(6, r.getIdPo());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCours(Cours c){
        try {
            String query = "UPDATE COURS SET nomCour = ?, idM = ?, dates = ?, heure = ?, duree = ? WHERE idCour = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setString(1, c.getNomCour());
            ps.setInt(2, c.getIdM());
            ps.setString(3, c.getDateCoursString());
            ps.setString(4, c.getHeureString());
            ps.setString(5, c.getDureeString());
            ps.setInt(6, c.getIdCour());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } 

    public void updateMoniteur(Moniteur m){
        try {
            String query = "UPDATE MONITEUR SET nomM = ?, prenomM = ? WHERE idM = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setString(1, m.getNomM());
            ps.setString(2, m.getPrenomM());
            ps.setInt(3, m.getIdM());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteReserver(int idC, int idCour, int idPo){
        try {
            String query = "DELETE FROM RESERVER WHERE idC = ? AND idCour = ? AND idPo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, idC);
            ps.setInt(2, idCour);
            ps.setInt(3, idPo);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCours(int id){
        try {
            String query = "DELETE FROM COURS WHERE idCour = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteMoniteur(int id){
        try {
            String query = "DELETE FROM MONITEUR WHERE idM = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteClient(int id){
        try {
            String query = "DELETE FROM CLIENT WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getMaxidPoney(){
        int max = 0;
        try {
            String query = "SELECT MAX(idPo) FROM PONEY";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                max = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return max;
    }
     
    public int getMaxidClient(){
        int max = 0;
        try {
            String query = "SELECT MAX(idC) FROM CLIENT";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                max = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return max;
    }

    public int getMaxidCours(){
        int max = 0;
        try {
            String query = "SELECT MAX(idCour) FROM COURS";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                max = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return max;
    }
        
    public int getMaxidMoniteur(){
        int max = 0;
        try {
            String query = "SELECT MAX(idM) FROM MONITEUR";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                max = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return max;
    }
}

