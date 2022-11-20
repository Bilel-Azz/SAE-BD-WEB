import java.util.Scanner;

public class Interface {
    public static void main(String[] args) {
        System.out.println("________________________________________________________");
        System.out.println("Bienvenue dans le programme de gestion de l'écurie de SAE");
        System.out.println("________________________________________________________");
        System.out.println("Veuillez choisir une option:");
        System.out.println("1. Gestion des poneys");
        System.out.println("2. Gestion des reservervations");
        System.out.println("3. Gestion des cours");
        System.out.println("4. Gestion des Moniteurs");
        System.out.println("5. Gestions des clients");
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
                System.out.println("________________________________________________________");
                System.out.println("Veuillez choisir une option:");
                System.out.println("1. Ajouter un poney");
                System.out.println("2. Modifier un poney");
                System.out.println("3. Supprimer un poney");
                System.out.println("4. Afficher les poneys");
                System.out.println("5. Retour");
                System.out.println("________________________________________________________");
                System.out.println("Veuillez entrer votre choix:");
                int choix2 = sc.nextInt();
                switch (choix2) {
                    case 1:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer les informations du poney:");
                        System.out.println("Nom:");
                        String nomPo = sc.next();
                        System.out.println("Age:");
                        int agePo = sc.nextInt();
                        System.out.println("Poids:");
                        int poidPo = sc.nextInt();
                        System.out.println("Poids supplementaire:");
                        int poidSup = sc.nextInt();
                        Poney p = new Poney(poney.getMaxidPoney(),nomPo, agePo, poidPo, poidSup);
                        poney.insertPoney(p);
                        break;
                    case 2:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du poney à modifier:");
                        int idPo = sc.nextInt();
                        System.out.println("Veuillez entrer les nouvelles informations du poney:");
                        System.out.println("Nom:");
                        String nomPo2 = sc.next();
                        System.out.println("Age:");
                        int agePo2 = sc.nextInt();
                        System.out.println("Poids:");
                        int poidPo2 = sc.nextInt();
                        System.out.println("Poids supplementaire:");
                        int poidSup2 = sc.nextInt();
                        Poney p2 = new Poney(idPo, nomPo2, agePo2, poidPo2, poidSup2);
                        poney.updatePoney(p2);
                        break;
                    case 3:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du poney à supprimer:");
                        int idPo3 = sc.nextInt();
                        poney.deletePoney(idPo3);
                        break;
                    case 4:
                        System.out.println("________________________________________________________");
                        System.out.println("Voici la liste des poneys:");
                        System.out.println(poney.getAllPoney());
                        
                        break;

                    case 5:
                        System.out.println("________________________________________________________");
                        System.out.println("Retour au menu principal");
                        break;
                    default:    
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer un choix valide");
                        break;  
                }
                break;
            case 2:
                System.out.println("________________________________________________________");
                System.out.println("Veuillez choisir une option:");
                System.out.println("1. Ajouter une reservation");
                System.out.println("2. Modifier une reservation");
                System.out.println("3. Supprimer une reservation");
                System.out.println("4. Afficher les reservations");
                System.out.println("5. Retour");
                System.out.println("________________________________________________________");
                System.out.println("Veuillez entrer votre choix:");
                int choix3 = sc.nextInt();
                switch (choix3) {
                    case 1:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer les informations de la reservation:");
                        System.out.println("Id du client:");
                        int idClient = sc.nextInt();
                        System.out.println("Id du cours:");
                        int idCours = sc.nextInt();
                        System.out.println("Id du poney:");
                        int idPoney = sc.nextInt();
                        Reserver r = new Reserver(idClient, idCours, idPoney);
                        poney.insertReserver(r);
                        break;
                    case 2:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du cours de la reservation à modifier:");
                        int idCours2 = sc.nextInt();
                        System.out.println("Veuillez entrer l'id du client:");
                        int idClient2 = sc.nextInt();
                        System.out.println("Veuillez entrer les nouvelles informations de la reservation:");
                        System.out.println("Id du poney:");
                        int idPoney2 = sc.nextInt();
                        Reserver r2 = new Reserver(idClient2, idCours2, idPoney2);
                        poney.updateReserver(r2);
                        break;
                    case 3:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du cours de la reservation à supprimer:");
                        int idCours3 = sc.nextInt();
                        System.out.println("Veuillez entrer l'id du client:");  
                        int idClient3 = sc.nextInt();
                        System.out.println("Veuillez entrer l'id du poney:");  
                        int idPoney3 = sc.nextInt();
                        poney.deleteReserver(idClient3, idCours3,idPoney3);
                        break;
                    case 4:
                        System.out.println("________________________________________________________");
                        System.out.println("Voici la liste des reservations:");
                        System.out.println(poney.getAllReserver());
                        break;

                    case 5:
                        System.out.println("________________________________________________________");
                        System.out.println("Retour au menu principal");
                        break;  

                    default:    
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer un choix valide");
                        break;
                }
                break;
            case 3:
                System.out.println("________________________________________________________");
                System.out.println("Veuillez choisir une option:");
                System.out.println("1. Ajouter un cours");
                System.out.println("2. Modifier un cours");
                System.out.println("3. Supprimer un cours");
                System.out.println("4. Afficher les cours");
                System.out.println("5. Retour");
                System.out.println("________________________________________________________");
                System.out.println("Veuillez entrer votre choix:");
                int choix4 = sc.nextInt();
                switch (choix4) {
                    case 1:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer les informations du cours:");

                        System.out.println("Nom:");
                        String nomCo = sc.next();
                        System.out.println("id du moniteur:");
                        int idMoniteur = sc.nextInt();
                        System.out.println("Date (AAAA-MM-JJ):");
                        String dateCo = sc.next();
                        System.out.println("Heure de debut (HH:MM:SS):");
                        String heureDebut = sc.next();
                        System.out.println("durée (HH:MM:SS):");
                        String duree = sc.next();
                        Cours c = new Cours(poney.getMaxidCours(),nomCo, idMoniteur, dateCo, heureDebut, duree);
                        poney.insertCours(c);
                        break;
                    case 2:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du cours à modifier:");
                        int idCo2 = sc.nextInt();
                        System.out.println("Veuillez entrer les nouvelles informations du cours:");
                        System.out.println("Nom:");
                        String nomCo2 = sc.next();
                        System.out.println("id du moniteur:");
                        int idMoniteur2 = sc.nextInt();
                        System.out.println("Date (AAAA-MM-JJ):");
                        String dateCo2 = sc.next();
                        System.out.println("Heure de debut (HH:MM:SS):");
                        String heureDebut2 = sc.next();
                        System.out.println("durée (HH:MM:SS):");
                        String duree2 = sc.next();
                        Cours c2 = new Cours(idCo2,nomCo2, idMoniteur2, dateCo2, heureDebut2, duree2);
                        poney.updateCours(c2);
                        break;
                    case 3:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du cours à supprimer:");
                        int idCo3 = sc.nextInt();
                        poney.deleteCours(idCo3);
                        break;
                    case 4:
                        System.out.println("________________________________________________________");
                        System.out.println("Voici la liste des cours:");
                        System.out.println(poney.getAllCours());
                        break;

                    case 5: 
                        System.out.println("________________________________________________________");
                        System.out.println("Retour au menu principal");
                        break;
        
                    default:    
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer un choix valide");
                        break; 
                        
                }
                break;
            case 4:
                System.out.println("________________________________________________________");
                System.out.println("Veuillez choisir une option:");
                System.out.println("1. Ajouter un moniteur");
                System.out.println("2. Modifier un moniteur");
                System.out.println("3. Supprimer un moniteur");
                System.out.println("4. Afficher les moniteurs");
                System.out.println("5. Retour");
                System.out.println("________________________________________________________");
                System.out.println("Veuillez entrer votre choix:");
                int choix5 = sc.nextInt();
                switch (choix5) {
                    case 1:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer les informations du moniteur:");
                        System.out.println("Nom:");
                        String nomMo = sc.next();
                        System.out.println("Prenom:");
                        String prenomMo = sc.next();

                        Moniteur m = new Moniteur(poney.getMaxidMoniteur(),nomMo, prenomMo);
                        poney.insertMoniteur(m);
                        break;
                    case 2:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du moniteur à modifier:");
                        int idMo2 = sc.nextInt();
                        System.out.println("Veuillez entrer les nouvelles informations du moniteur:");
                        System.out.println("Nom:");
                        String nomMo2 = sc.next();
                        System.out.println("Prenom:");
                        String prenomMo2 = sc.next();
                        Moniteur m2 = new Moniteur(idMo2,nomMo2, prenomMo2);
                        poney.updateMoniteur(m2);
                        break;
                    case 3:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du moniteur à supprimer:");
                        int idMo3 = sc.nextInt();
                        poney.deleteMoniteur(idMo3);
                        break;
                    case 4:
                        System.out.println("________________________________________________________");
                        System.out.println("Voici la liste des moniteurs:");
                        System.out.println(poney.getAllMoniteur());
                        break;
                    case 5: 
                        System.out.println("________________________________________________________");
                        System.out.println("Retour au menu principal");
                        break;
                }
                break;
            case 5:
                System.out.println("________________________________________________________");
                System.out.println("Veuillez choisir une option:");
                System.out.println("1. Ajouter un client");
                System.out.println("2. Modifier un client");
                System.out.println("3. Supprimer un client");
                System.out.println("4. Afficher les clients");
                System.out.println("5. Retour");
                System.out.println("________________________________________________________");
                System.out.println("Veuillez entrer votre choix:");
                int choix6 = sc.nextInt();
                switch (choix6) {
                    case 1:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer les informations du client:");
                        System.out.println("Nom:");
                        String nomCl = sc.next();
                        System.out.println("Prenom:");
                        String prenomCl = sc.next();
                        System.out.println("poids:");
                        int poidsCl = sc.nextInt();
                        System.out.println("y'a t'il la cotisation ?(O/N):");
                        String cotisationCl = sc.next();
                        Client c ;
                        if (cotisationCl.equals("O")) {
                            c = new Client(poney.getMaxidClient(),nomCl, prenomCl, poidsCl, true);
                        } else {
                            c = new Client(poney.getMaxidClient(),nomCl, prenomCl, poidsCl, false);
                        }
                        poney.insertClient(c);
                        break;
                    case 2:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du client à modifier:");
                        int idCl2 = sc.nextInt();
                        System.out.println("Veuillez entrer les nouvelles informations du client:");
                        System.out.println("Nom:");
                        String nomCl2 = sc.next();
                        System.out.println("Prenom:");
                        String prenomCl2 = sc.next();
                        System.out.println("poids:");
                        int poidsCl2 = sc.nextInt();
                        System.out.println("y'a t'il la cotisation ?(O/N):");
                        String cotisationCl2 = sc.next();
                        Client c2 ;
                        if (cotisationCl2.equals("O")) {
                            c2 = new Client(idCl2,nomCl2, prenomCl2, poidsCl2, true);
                        } else {
                            c2 = new Client(idCl2,nomCl2, prenomCl2, poidsCl2, false);
                        }
                        poney.updateClient(c2);
                        break;
                    case 3:
                        System.out.println("________________________________________________________");
                        System.out.println("Veuillez entrer l'id du client à supprimer:");
                        int idCl3 = sc.nextInt();
                        poney.deleteClient(idCl3);
                        break;
                    case 4:
                        
                        System.out.println("________________________________________________________");
                        System.out.println("Voici la liste des clients:");
                        System.out.println(poney.getAllClient());
                        break;
                    case 5:
                        
                        System.out.println("________________________________________________________");
                        System.out.println("Retour au menu principal");
                        break;
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
