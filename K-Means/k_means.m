% K-Means D. D'A. 20221950

%Import de donnée et arrangement de celles-ci
M = importdata('K_Means_Data_Base.xlsx');
M = M.data;
%Nombre de clusters voulu
cmax = 15;
%Création de matrice pour la mémoire
elbow = [0;0];
C = elbow;
K = [0,0];
Groupe = zeros(718,1);
%Activation de la visualisation
visual = 1;

if visual
    %Visualisation graphique de la base de données
    hold on
    scatter(M(:,1),M(:,2),"filled","blue")
end

%Boucle qui nous permet d'incrémenter le nombre de centrïons (ici fixer au
%maximum de 9, il peut bien entendu être modifier à la convenance de chacun)
for c = 1 : cmax
    %Les centrïons seront stocké dans la matrice K et le premier sera
    %choisi aléatoirement ainsi que le deuxième. Attention qu'à chaque
    %boucle c, il reprend les même centrions qu'avant, il ne fait qu'en
    %mettre un de plus aléatoirement.
    K(c,:) = rand(1,2)*100;
    %Visualisation graphique des centrïons initiaux
    if visual
        scatter(K(:,1),K(:,2),"red","filled")
    end
    %Création d'un bool pour ne pas avoir une boucle infinie
    again = true;
    %Boucle qui va nous faire rapprocher de nos centrïons finaux
    while again
        %On fixe T qui va être notre mémoire de comparaison de K car
        %celui-ci va changer.        
        T = K;
        %La boucle total nous permet d'analyser la distance entre un
        %centrïon et tout les points de notre data.
        %Pour la boucle principale, elle va simplement nous donner tout les
        %points en coordonnées de notre data.
        for i = 1:718
            point = [M(i,:)];
            %La première boucle secondaire va mémorisé la distance entre un
            %centrïon et un point dans une nouvelle matrice appelée C, il
            %est important de remarquer que les lignes correspondent aux
            %points et les colonnes aux différents centrïons.
            for j = 1:c
                C(i,j) = norm(point-[K(j,:)]);
            end
            %Pour la deuxième boucle secondaire, nous commençons par
            %analyser, hors boucle, chaques distances d'un point par rapport à l'entièreté 
            %des centrïons et prenons la plus petite
            %Ensuite les la distance minimale devient alors la seule
            %distance, nous égalons les autres à 0 en boucle.
            m = min(C(i,:));
            for j = 1:c
                if C(i,j) ~= m
                    C(i,j) = 0;
                end
            end
            %Donc à la fin nous aurons par chaque point un et unique centrïon et par
            %chaque centrïon un et unique ensemble de points, les 0 sont très
            %importants, il ne faut pas les supprimé sinon, nous perdrons
            %la surjection entre les points vers centrïons.
        end 
        %Pour la prochaine boucle, nous allons recalculer la position de
        %nos centrïons en passant par le bary-centre, le principe est de
        %simuler un centre de masse avec la masse d'un point (pour tout point) égale à 1
        %divisé par le nombre de point.
        %Donc la boucle principale va balayer tout les centrïons
        for j = 1:c
            %Nous noterons que les données ici, seront utiles pour que
            %matlab sache de quoi on parle et aussi,
            %pour que la boucle ne prenne pas en compte les résultats
            %précédent.
            bary = [0,0];
            count = 0;
            %Pour la boucle secondaire, elle va analyser chaque point et va
            %reternir l'addition ainsi que le nombre de point choisi par
            %centrïon
            for i = 1:718
                %La condition permet de retrouver le centrïons
                %correspondant à un point (utilité de la surjection).
                if C(i,j) ~= 0
                    bary = bary + M(i,:);
                    count = count + 1;
                end
                %Classification par groupe
                %En balayage
                if c == cmax
                    if C(i,j) > 0
                        Groupe(i,1) = j;
                    end
                end
            end
            %La condition suivante est une condition de sécurité via le
            %barycentre, car nous pourrions diviser par zéro, donc si le
            %nombre de points est nul, alors nous ne modifierons pas
            %celui-ci
            if count ~= 0
                K(j,:) = bary/count;
            end
        %Donc à la fin de celle-ci, nous aurons déterminé nos nouveaux
        %centrïons
        end
        if visual
            %Visualisation des mouvements de centrïons
            scatter(K(:,1),K(:,2),"green","filled")
        end
        %Nous allons nous servir de notre mémoire de comparaison pour
        %justement comparer avant et après la boucle. Si les même alors,
        %nous aurons nos centrïons fixes.
        %Cette condition nous sert à stoper via un booléen la boucle
        %supposée infinie.
        if T == K
            again = false;
        end
    end
    if visual
        %Visualisation des points finaux (le nombre dépend du nombre de
        %centrïons maximum, ici 9)
        scatter(K(:,1),K(:,2),"magenta","filled")
    end
    %Ici nous construisons une matrice qui nous servira juste ci-dessous,
    %La matrice correspond à la distortion par centrïons.
    elbow(c,1) = c;
    elbow(c,2) = sum(sum(C.^2));
end

if visual
    %Visualisation graphique pour déterminer le nombre de centrïon adéquat.
    figure('Name','Elbow Method','NumberTitle','off');
    scatter(elbow(:,1),elbow(:,2),"*")
end
disp(Groupe)
