%Fonction déterminant la colormap adéquate
    function [] = Colorworld(LogicalValue,Matrix,MatrixSize)
        %Condition interne par rapport à un booléen pouvant changer
            if LogicalValue
                %Condition de la fin du feu de forêt
                    if sum(Matrix==3,'all')==0
                        %Condition de la présence de rivière
                            if sum(Matrix==10,'all') == 0
                                %Condition sur le nombre de "plaine" 
                                    if sum(Matrix(2:MatrixSize-1,2:MatrixSize-1)==0,'all')==0
                                        %Mise d'une colormap adéquate
                                            colormap([0.1961,0.8039,0.1961;0.4,0.4,0.4])
                                    else
                                        %Mise d'une colormap adéquate
                                            colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4])
                                    end
                            elseif sum((Matrix==2),'all') == 1
                                %Mise d'une colormap adéquate
                                    colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0,1])
                            end
                    else
                        %Condition sur le nombre de "plaine"
                            if sum(Matrix(2:MatrixSize-1,2:MatrixSize-1)==0,'all')==0
                                %Condition sur la présence d'une rivière
                                    if sum(Matrix==10,'all') > 0
                                        %Condition sur la présence d'arbre
                                            if sum(Matrix(2:MatrixSize-1,2:MatrixSize-1)==1,'all')==0
                                                %Mise d'une colormap adéquate
                                                    colormap([0.4,0.4,0.4;0.9,0,0;0.1961,0.8039,0.1961;0.9,0,0;0.9,0,0;0.4,0.4,0.4;0.9,0,0;0,0,1])
                                            else
                                                %Mise d'une colormap adéquate
                                                    colormap([0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0;0.1961,0.8039,0.1961;0.9,0,0;0.9,0,0;0.4,0.4,0.4;0.9,0,0;0,0,1])
                                            end
                                    %Condition sur la présence d'arbre
                                        elseif sum(Matrix(2:MatrixSize-1,2:MatrixSize-1)==1,'all')==0
                                            %Mise d'une colormap adéquate
                                                colormap([0.4,0.4,0.4;0.9,0,0])
                                    else
                                        %Mise d'une colormap adéquate
                                            colormap([0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0])
                                    end
                                
                            elseif sum(Matrix==10,'all') > 0
                                %Mise d'une colormap adéquate
                                    colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0.3,0;0,0,1])
                            else
                                %Mise d'une colormap adéquate
                                    colormap([1,1,1;0.1961,0.8039,0.1961;0.4,0.4,0.4;0.9,0,0])
                            end
                    end
            end
    end