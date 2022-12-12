% Feu de Forêt D. D'A. 20221950

%Gestion des variables et constantes
    %Fixation de la taille de la forêt
        SizeWorld = input('Size of forest : ');
    %Fixation de caractère variable
        View = false;
        River_ON = false;
        Wind_ON = false;

%Caractérisation de la simulation
    %Initialisation de la boucle suivante
        Choice = true;
    %Boucle principale
        while Choice
            %Choix de l'usage du programme
                To_do = upper(input('View fire or Study it ? [V/S] ','s'));
            %Modifications de variable par rapport au choix ci-dessus
                switch To_do
                    %Dans le cas où, l'utilisateur voudrait voir une
                    %simulation visuel d'un feu de forêt
                        case 'V'
                            %Changement de la variable responsable de la
                            %visualisation
                                View = true;
                            %Assignation aux variables suivantes à une
                            %constante de 1, elles serviront par la suite
                            %pour une boucle à 1 passage
                                Average_loop = 1;
                                Details_Density = 1;
                                Max_Cut_Density = 1;
                            %Boucle récurrente jusqu'à ce qu'une densité
                            %soit idéalle
                                while Choice
                                    %Demande d'une densité à l'utilisateur
                                        Density = input('Density ? [%]')/100;
                                    %Condition sur le fait d'une densité
                                    %adéquate
                                        if not(Density < 0) && Density <= 1
                                            %Changement de la variable,
                                            %annulant la boucle ci-dessus,
                                            %ainsi que la boucle principale
                                                Choice = false;
                                        end
                                end
                            %Demande à l'utilisateur sur les options de la
                            %simulation
                                % Condition de l'utilisateur sur le vent
                                    if upper(input('Include wind ? [Y/N] ','s')) == 'Y'
                                        %Assignation à la variable sur un
                                        %booléen true
                                            Wind_ON = true;
                                    end
                                % Condition de l'utilisateur sur la rivière
                                    if upper(input('Include river ? [Y/N] ','s')) == 'Y'
                                        %Assignation à la variable sur un
                                        %booléen true
                                            River_ON = true;
                                    end
                    %Dans le cas où, l'utilisateur voudrait faire une
                    %analyse de la simulation
                        case 'S'
                            %Demande à l'utilisateur les paramètres à
                            %configurer
                                %Demande le nombre de découpage du pourcentage
                                %du nombre d'arbre brulé par rapport aux
                                %arbres initiaux
                                    Max_Cut_Density = input('Details of density ? ');
                                    Details_Density = Max_Cut_Density;
                                %Demande du nombre de simulation par la
                                %même densité anfin de faire la moyenne
                                    Average_loop = input('Average loop ? ');
                            %Création d'un stockage pour les futures données
                                DataForest = zeros(Details_Density,1);
                            %Assignation d'un booléen à la variable
                            %suivante pour arrêter la boucle principale
                                Choice = false;
            
                end
            %Réinitialisation de la variable suivante qui n'aura plus usage
                clear To_do
        end
%Boucle permettant l'étude d'arbre brûlé par rapport à la densité d'arbre
%Cette boucle sera référée par (1)
    for Instant_Density = 1 : Max_Cut_Density
        %Boucle permettant une moyenne d'arbre broûlé pour une même
        %densitée; Cette boucle sera référée par (2)
            for Instant_Loop = 1 : Average_loop
                %Choix de la densité en fonction de la variable décidée par
                %l'utilisateur (Ln. 23)
                    if View == false
                        %Densitée modifiée à chaque itération par la boucle (1)
                            Details_Density = Instant_Density/Max_Cut_Density;
                    else
                        %Densitée fixée par l'utilisateur (Ln. 31)
                            Details_Density = Density;
                    end

                %Création des données nécéssaires pour la simulation
                    %Création de la matrice représentant le monde avec les
                    %dimensions choisies par l'utilisateur (Ln. 5)
                    %additionnée à 2 pour avoir 2 colonnes et 2 lignes de
                    %zéros supplémentaire étant les bordures du monde
                        World = zeros(SizeWorld+2);
                    %Génération des arbres en fonction de la densité dans
                    %le centre de la matrice World laissant les bordures de zéros
                        World(2:SizeWorld+1,2:SizeWorld+1) = rand(SizeWorld)<Details_Density;
                    %Première génération du premier arbre en feu
                        Boot = randi([1,size(World,2)],1,2);
                    %Comptage d'arbre dans la simulation
                        Tree_Init = sum((World==1),'all');
                
                %Gestion des paramètres optionnels
                    %Vent
                        if Wind_ON == true
                            %Direction du vent aléatoire
                                Wind_Direction = randi([-2,2],1,1);
                        else
                            %Si le vent n'est pas demandé, sa direction
                            %sera affilié à 0
                                Wind_Direction = 0;
                        end

                    %Rivière
                        if River_ON == true
                            %Génération de la rivière
                                %Centre de la rivière généré aléatoirement
                                    River = randi([3,SizeWorld-1],1,1);
                                %Boucle de création de la rivière ligne
                                %par ligne de la matrice de la simulation
                                    for i = 2:SizeWorld+1
                                        %Modification des valeurs de base 
                                        %en valeur désignant l'eau en un points
                                            World(i,randi([River-2,River-1],1,1):randi([River+1,River+2],1,1)) = 10;
                                        %Condition de sécurité pour que la
                                        %rivière ne sorte pas de la zone de
                                        %simulation
                                            if River == SizeWorld-1
                                                %Si elle se trouve sur
                                                %l'extremité droite
                                                %il y a une chance
                                                %non nulle que la rivière se
                                                %"déplacer" vers la gauche
                                                    if rand(1,1) < 0.7
                                                        River = River -1;
                                                    end
                                            elseif River == 3
                                                %Si elle se trouve sur 
                                                %l'extremité gauche
                                                %il y a une chance
                                                %non nulle que la rivière se
                                                %"déplacer" vers la droite
                                                    if rand(1,1) < 0.7
                                                        River = River + 1;
                                                    end
                                            else
                                                %Sinon elle aura une chance
                                                %non nulle de se "déplacer"
                                                %vers la droite ou la gauche
                                                    if rand(1,1) > 0.65
                                                        River = River + 1;
                                                    elseif rand(1,1) < 0.35
                                                        River = River - 1;
                                                    end
                                            end
                                    end
                        end
                %Choix de la color map par la fonction, celle-ci est
                %expliquée dans celle-ci
                    Colorworld(View,World,SizeWorld)
                %Boucle de modification du premier arbre mis en feu (Ln 108)
                %Elle ne s'arrêtera que sous deux conditions:
                % Si elle trouve un arbre à enflammer ou s'il n'y en a pas.
                    while World(Boot(1,1),Boot(1,2)) ~= 1
                        %Modification de la coordonnée initiale
                            Boot = randi([1,size(World,2)],1,2);
                        %Arrêt de la boucle si aucun arbre dans la matrice
                            if Tree_Init == 0
                                break
                            end
                    end

                %Initialisation du feu
                    World(Boot(1,1),Boot(1,2))=3;


                %Création d'une matrice permettant de voir les
                %modifications itération par itération
                    GhostWorld = World;
                
                %Initialisation de la boucle responsable de la propagation 
                    Fire = true;
                %Boucle de propagation du feu
                    while Fire
                        %Arrêt de sécurité le cas où il n'y à pas d'arbre
                            if Tree_Init == 0
                                break
                            end
                        %Modification du vent en temps réel si
                        %l'utilisateur a choisi de mettre du vent
                            if Wind_ON == true
                                %Chance non nul que la direction du vent
                                %change en temps réel
                                    if rand(1,1)<0.03
                                        %En fonction du vent actuel
                                            switch norm(Wind_Direction)
                                                %Dans le cas où le vent se dirige sur l'axe verticale
                                                    case 1
                                                        %Alors la direction est soit nulle soit horizontale    
                                                            Wind_Direction = randi([-1,1],1,1)*2;
                                                %Dans le cas où le vent se dirige sur l'axe verticale
                                                    case 2
                                                        %Alors la direction est soit nulle soit verticale
                                                            Wind_Direction = randi([-1,1],1,1);
                                                %Dans le cas où il n'y a pas de vent
                                                    otherwise
                                                        %Alors la direction sera aléatoire
                                                            Wind_Direction = randi([-2,2],1,1);
                                            end
                                    end
                            end
                        %Double boucle pour balayer la matrice de simulation
                            for j = 2 : size(World,2)-1
                                for i = 2 : size(World,1)-1
                                    %Condition testant si un arbre brûle
                                        if World(i,j) == 3
                                            %Déplacement du feu en fonction
                                            %du vent
                                                switch norm(Wind_Direction)
                                                    %Dans le cas où il n'y a pas de vent
                                                        case 0
                                                            %Condition regardant s'il a un arbre en dessous de celui en feu
                                                                if World(i+1,j) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i+1,j) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre au dessus de celui en feu
                                                                if World(i-1,j) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i-1,j) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre à droite de celui en feu
                                                                if World(i,j+1) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i,j+1) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre à gauche de celui en feu
                                                                if World(i,j-1) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i,j-1) = 3;
                                                                end
                                                    %Dans le cas où la direction du vent est verticale
                                                        case 1
                                                            %Condition regardant s'il a un arbre directement à coté de celui en feu
                                                            %Le signe de la variable "Wind_Direction" désignant le sens de propagation
                                                                if World(i+(1*Wind_Direction),j) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i+(1*Wind_Direction),j) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre en diagonale à gauche de celui en feu
                                                            %Le signe de la variable "Wind_Direction" désignant le sens de propagation
                                                                if World(i+(1*Wind_Direction),j-1) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i+(1*Wind_Direction),j-1) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre en diagonale à droite de celui en feu
                                                            %Le signe de la variable "Wind_Direction" désignant le sens de propagation
                                                                if World(i+(1*Wind_Direction),j+1) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i+(1*Wind_Direction),j+1) = 3;
                                                                end
                                                    %Dans le cas où la direction du vent est verticale
                                                        case 2
                                                            %Condition regardant s'il a un arbre directement à coté de celui en feu
                                                            %Le signe de la variable "Wind_Direction" désignant le sens de propagation
                                                                if World(i,j+(1*(Wind_Direction/2))) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i,j+(1*(Wind_Direction/2))) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre en diagonale en bas de celui en feu
                                                            %Le signe de la variable "Wind_Direction" désignant le sens de propagation
                                                                if World(i-1,j+(1*(Wind_Direction/2))) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i-1,j+(1*(Wind_Direction/2))) = 3;
                                                                end
                                                            %Condition regardant s'il a un arbre en diagonale en haut de celui en feu
                                                            %Le signe de la variable "Wind_Direction" désignant le sens de propagation
                                                                if World(i+1,j+(1*(Wind_Direction/2))) == 1
                                                                    %Modification de l'arbre en cette position à un arbre en feu
                                                                    %dans la copie de la matrice principale
                                                                        GhostWorld(i+1,j+(1*(Wind_Direction/2))) = 3;
                                                                end
                                                end
                                            %Modification de l'arbre initialement en feu à un arbre brûlé/en cendre
                                            %dans la copie de la matrice principale
                                                GhostWorld(i,j) = 2;
                        
                                        end
                                end
                            end

                        %égalisation de la copie de la matrice principale et celle-ci
                            World = GhostWorld;

                        %Choix de la color map par la fonction
                            Colorworld(View,World,SizeWorld)
                        
                        %Condition regardant le nombre d'arbre encore en feu
                            if sum((World-3)==0)==0
                                %Arrêt de la boucle de propagation du feu
                                    Fire = false;
                            end
                        %Condition du choix d'observation de l'utilisateur 
                        if View
                            %Visualisation de la simulation et
                            %actualisation de celle-ci
                                pcolor(World(2:SizeWorld,2:SizeWorld));
                                drawnow;
                        end
                    end
                %Condition du choix d'analyse de l'utilisateur
                    if not(View)
                        %Sécurité de rapport entre les arbres brûlés et
                        %ceux initiaux
                            if Tree_Init == 0 
                                %Passage à la prochaine itération pour
                                %éviter de diviser par 0
                                    continue
                            else
                                %Stockage des pourcentages d'arbres brulés
                                %par le nombre d'arbre initiaux
                                    DataForest(Instant_Density,1) = DataForest(Instant_Density,1) + (sum((World(2:SizeWorld+1,2:SizeWorld+1)==2),'all')/Tree_Init);
                            end
                    end
            end
    end

%Traitement des données récoltées s'il en était le but de l'utilisateur
    if not(View)
        %Moyenne des données selon le degré de précision voulu par l'utilisateur
            DataForest = DataForest/Average_loop;
        %Aspect graphique
            %Superposition des graphiques
                hold on
            %Graphique des points des données récoltées
                scatter(((0:size(DataForest,1))/Max_Cut_Density),[0;DataForest])
            %Lissage des données récoltées
                plot(((0:size(DataForest,1))/Max_Cut_Density),smooth([0;DataForest]))
            %Détails du graphique 
                %Titre global
                    title('Burned trees in relation to initial trees by density')
                %Titre de l'axe des abscices 
                    xlabel("Density")
                %Titre de l'axe des ordonnées
                    ylabel("Burned trees by initial trees")
                %Légende
                    legend('Original points','Smoothed points')
    end