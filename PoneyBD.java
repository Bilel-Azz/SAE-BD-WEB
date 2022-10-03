public class PoneyBD {
    private ConnexionMySQL co;

    public PoneyBD(ConnexionMySQL co) {
        this.co = co;
    }

    public void insertPoney(Poney p) {
        try {
            String query = "INSERT INTO Poney (idPo, nomPo, agePo, poidPo, poidSup) VALUES (?,?,?,?,?)";
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
            String query = "INSERT INTO Client (idC, nomC, prenomC, adresseC, telC) VALUES (?,?,?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, c.getIdC());
            ps.setString(2, c.getNomC());
            ps.setString(3, c.getPrenomC());
            ps.setString(4, c.getAdresseC());
            ps.setString(5, c.getTelC());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertMoniteur(Moniteur m) {
        try {
            String query = "INSERT INTO Moniteur (idM, nomM, prenomM, adresseM, telM) VALUES (?,?,?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, m.getIdM());
            ps.setString(2, m.getNomM());
            ps.setString(3, m.getPrenomM());
            ps.setString(4, m.getAdresseM());
            ps.setString(5, m.getTelM());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertCours(Cours c) {
        try {
            String query = "INSERT INTO Cours (idCo, idM, idC, idPo, dateCo, heureDebut, heureFin, prixCo) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, c.getIdCo());
            ps.setInt(2, c.getIdM());
            ps.setInt(3, c.getIdC());
            ps.setInt(4, c.getIdPo());
            ps.setDate(5, c.getDateCo());
            ps.setTime(6, c.getHeureDebut());
            ps.setTime(7, c.getHeureFin());
            ps.setDouble(8, c.getPrixCo());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertReserver(Reserver r) {
        try {
            String query = "INSERT INTO Reserver (idC, idCo) VALUES (?,?)";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, r.getIdC());
            ps.setInt(2, r.getIdCo());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Client getClient(id int){
        Client c = null;
        try {
            String query = "SELECT * FROM Client WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                c = new Client(rs.getInt("idC"), rs.getString("nomC"), rs.getString("prenomC"), rs.getString("adresseC"), rs.getString("telC"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
    }

    public Poney getPoney(id int){
        Poney p = null;
        try {
            String query = "SELECT * FROM Poney WHERE idPo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                p = new Poney(rs.getInt("idPo"), rs.getString("nomPo"), rs.getInt("agePo"), rs.getInt("poidPo"), rs.getInt("poidSup"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
    }
    
    public Moniteur getMoniteur(id int){
        Moniteur m = null;
        try {
            String query = "SELECT * FROM Moniteur WHERE idM = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                m = new Moniteur(rs.getInt("idM"), rs.getString("nomM"), rs.getString("prenomM"), rs.getString("adresseM"), rs.getString("telM"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
    }

    public Cours getCours(id int){
        Cours c = null;
        try {
            String query = "SELECT * FROM Cours WHERE idCo = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                c = new Cours(rs.getInt("idCo"), rs.getInt("idM"), rs.getInt("idC"), rs.getInt("idPo"), rs.getDate("dateCo"), rs.getTime("heureDebut"), rs.getTime("heureFin"), rs.getDouble("prixCo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
    }

    public Reserver getReserver(id int){
        Reserver r = null;
        try {
            String query = "SELECT * FROM Reserver WHERE idC = ?";
            PreparedStatement ps = co.getConnexion().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                r = new Reserver(rs.getInt("idC"), rs.getInt("idCo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
    }
}
