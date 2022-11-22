% K-Means D. D'A. 20221950

%Gestion de la base de donnée
    %Importation de donnée et arrangement
        Data = importdata('K_Means_Data_Base.xlsx');
        Data = Data.data;
    %Nombre de point
        DataSize = size(Data,1);

%Mise en place des variables/constantes
    %Nombre de cluster
        Cmax = 16;
    %Compteur d'Itération
        Ite = 0;
    %Matrice mémoire 
        %Mouvements des clusters
            ClustMoveX = zeros(Cmax,1);
            ClustMoveY = zeros(Cmax,1);
        %Coordonnées des différents clusters
            Cluster = [0,0];
        %Distorsion par rapport au nombre de clusters
            elbow = [0,0];
        %Distance par rapport au différents clusters
            Norm = [0;0];
        %Affiliation des coordonnée au numéro du cluster
            Group = [0;0];

%Boucle ajoutant cluster par cluster (1)
    for c = 1 : Cmax
        %Ajout d'un couple de coordonée aléatoire d'un nouveau cluster sans
        %modifier les précédents
            Cluster(c,:) = rand(1,2)*100;
        %Booléen assigné à une variable
            Continuity = true;

        %Boucle déclanchée en fonction de la variable ci-dessus 
            while Continuity
                %Mémorisation des clusters rentrants
                    ClustMemory = Cluster;

                %Condition sur c, fixer par la boucle (1), étant le nombre voulu de cluster
                    if c == Cmax
                        %Comptage d'itération
                            Ite = Ite + 1; 
                        %Mémorisation de la position en X et Y (vecteurs distincts)
                        %des cluster par itération(colonne)
                            ClustMoveX(:,Ite) = Cluster(:,1);
                            ClustMoveY(:,Ite) = Cluster(:,2);
                    end

                %Boucle du nombre de coordonnées (2)
                    for i = 1:DataSize

                        %Boucle du nombre intérmédiaire de cluster (3)
                            for j = 1:c
                                %Calcul de la distance entre un point fixer
                                %par la boucle (2) et d'un cluster fixer par la boucle (3)
                                    Norm(i,j) = norm(Data(i,:)-Cluster(j,:));
                            end

                        %Variable étant la distance minimum du même point
                        %(donné par (2))entre les différents clusters
                            minimum = min(Norm(i,:));
                        %Modification de la matrice Norm (par (2)), en réduisant les
                        %distances non égale au minimum d'entre elles à 0
                            Norm(i,:) = (Norm(i,:) == minimum)*minimum;
                    end 
                
                %Boucle du nombre intérmédiaire de cluster (4)
                    for j = 1:c
                        %Variable réinitialisée par (4)
                            Barycentre = [0,0];
                        %Compteur de point affilié à un cluster,
                        %réinitialisé par la boucle (4)
                            Count = 0;

                        %Boucle du nombre de coordonnées (5)
                            for i = 1:DataSize
                                
                                %Condition de distance non nul
                                    if Norm(i,j) ~= 0
                                        %Somme des points affilié à un
                                        %cluster
                                            Barycentre = Barycentre + Data(i,:);
                                        %Actualisation du compteur 
                                            Count = Count + 1;
                                    end
                                
                                %Condition sur c, fixer par la boucle (1), 
                                %étant le nombre voulu de cluster et la
                                %distance non nul entre le point et les
                                %clusters
                                    if c == Cmax && Norm(i,j) > 0
                                        %Affiliation mémorisée par point et
                                        %par numérotation des clusters
                                            Group(i,1) = j;
                                    end
                            end
            
                        %Modification des clusters (par (4))
                            %Cas où le cluster est non vide
                                if Count ~= 0
                                    %Modification du cluster par son barycentre
                                        Cluster(j,:) = Barycentre/Count;
                            %Cas où le cluster est vide
                                else
                                    %Modification du cluster aléatoirement
                                        Adjustment = rand(1,2)*100;

                                        %Sécurité du critère aléatoire,
                                        %car chance non nul où l'ajustement
                                        %soit égal à celle à modifier
                                            while Cluster(j,:) == Adjustment
                                                Adjustment = rand(1,2)*100;
                                            end

                                        Cluster(j,:) = Adjustment;
                                end
                    end

                %Condition d'égalité entre les coordonnées avant et après
                %modification
                    if ClustMemory == Cluster
                        %Modification du critère d'activation de la boucle
                        %while
                            Continuity = false;
                    end
            end
        %Mémorisation du calcul de la distorsion par rapport au nombre de
        %cluster déterminé par (1)
            elbow(c,:) = [c,sum(Norm.^2,'all')];
    end

%Calcul du nombre de cluster adéquat
    %Boucle de du nombre de cluster (6)
        for i = 1 : Cmax
            
            %Condition d'ajout de précision inférieur à 5 pourcent
                if ((elbow(i,2)/sum(elbow(:,2)))*100) < 5
                    %Sortie de celui-ci et remise à la ligne
                        fprintf("The optimal number of clusters is %d",i-1); disp(' ')
                    %Arrêt de la boucle (6) car il nous faut le premier où
                    %la précision est inférieur à 5 pourcent
                        break
                end
        end

%Condition de l'utilisateur pour voir les différents graphiques suivants
    if input("Show graphics ? [Y/N] ",'s') == "Y"

        %Nuage de points du déplacement des clusters par rapport aux deux
        %dernier nombre de cluster
            figure('Name','Cluster move','NumberTitle','off');
            %Superposition des trois graphiques suivant
                hold on
            %Nuage de points
                %Points
                    scatter(Data(:,1),Data(:,2),"blue","filled")
                %Déplacements
                    scatter(ClustMoveX,ClustMoveY,"green","filled")
                %Clusters finaux
                    scatter(Cluster(:,1),Cluster(:,2),"red","filled")

        %Graphique de la méthode de l'elbow
            figure('Name','Elbow Method','NumberTitle','off');
            %Superposition des trois graphiques suivant
                hold on
            %Points reliés
            scatter(elbow(:,1),elbow(:,2),"filled")
            plot(elbow(:,2),'red')

        %Graphique de groupement des points par couleurs
            %Choix des triplets RGB pour chaque cluster
                color = rand(Cmax,3);
                figure('Name','Group','NumberTitle','off');
            %Superposition des set de points suivants 
                hold on

             %Boucle de du nombre de cluster (7)
                for i = 1 : Cmax
                    %Réinitialisation des variable
                        Scax = [0;0];
                        Scay = [0;0];
                        Count = 0;

                    %Boucle du nombre de coordonnées (8)
                        for j = 1 : DataSize

                            %Condition d'appartenance d'un point désigné par (8)
                            %à un cluster désignépar (7)
                                if Group(j,1) == i
                                    %Construction des coordonnées en x et y
                                    %séparé en matrice pour un cluster
                                        Count = Count + 1;
                                        Scax(Count,1) = Data(j,1);
                                        Scay(Count,1) = Data(j,2);
                                end
                        end
                        %Nuage de point suivant les coordonnées et la
                        %couleur attribué précédemment
                            scatter(Scax,Scay,[],color(i,:),'filled')
                end
    end
