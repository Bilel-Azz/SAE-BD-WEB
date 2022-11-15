import java.util.Scanner;

public class Interface {
    public static void main(String[] args) {
        System.out.println("________________________________________________________");
        System.out.println("Bienvenue dans le programme de gestion de l'écurie de SAE");
        System.out.println("________________________________________________________");
        System.out.println("Veuillez choisir une option:");
        System.out.println("1. Afficher les chevaux");
        System.out.println("2. Afficher les moniteurs");
        System.out.println("3. Afficher les cours");
        System.out.println("4. Afficher les réservations");
        System.out.println("5. Afficher les clients");
        System.out.println("6. Quitter");
        System.out.println("________________________________________________________");
        System.out.println("Veuillez entrer votre choix:");
        Scanner sc = new Scanner(System.in);
        int choix = sc.nextInt();
        ConnexionMySQL co ;

        String loginMySQL = "aazzouz" ;
        String mdpMySQL = "aazzouz" ;
        String nomServeur = "servinfo-mariadb" ;
        String nomBase = "DB" + loginMySQL ;
        co = new ConnexionMySQL ( nomServeur , nomBase , loginMySQL , mdpMySQL ) ;
        if ( co . getConnecte () ) {
            System . out . println ( " La connexion c ’ est bien pass  ́e e " ) ;
        PoneyBD poney = new PoneyBD(co);
        switch (choix) {
            case 1:
                System.out.println("Afficher les chevaux");
                for (Poney p : poney.getAllPoney()) {
                    System.out.println(p);
                }
                break;
            case 2:
                System.out.println("Afficher les moniteurs");
                for (Moniteur m : poney.getAllMoniteur()) {
                    System.out.println(m);
                }
                break;
            case 3:
                System.out.println("Afficher les cours");
                for (Cours c : poney.getAllCours()) {
                    System.out.println(c);
                }
                break;
            case 4:
                System.out.println("Afficher les réservations");
                for (Reserver r : poney.getAllReserver()) {
                    System.out.println(r);
                }
                break;
            case 5:
                System.out.println("Afficher les clients");
                for (Client c : poney.getAllClient()) {
                    System.out.println(c);
                }
                break;
            case 6:
                System.out.println("Quitter");
                break;
            default:
                System.out.println("Veuillez entrer un choix valide");
                break;
        }
    }
}}
