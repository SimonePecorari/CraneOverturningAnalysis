## ANALISI RIBALTAMENTO DI UNA GRU SU UN AUTOCARRO

## OBIETTIVO
L’obiettivo del progetto è determinare il ribaltamento di una gru posta sopra un autocarro, dopo aver definito i dati geometrici,  ottenuti da una scheda tecnica di un’autogrù già esistente; quindi si va ad individuare il carico ammissibile affinché l’autocarro non si ribalti.

## SOFTWARE UTILIZZATI
- Matlab
    - Analisi della cinematica diretta;

    - Definizione dello spazio dei giunti;

    - Analisi statica e dinamica: calcolo della massa limite di sollevamento (verifica del ribaltamento del mezzo);

    - Confronto dei plot ottenuti con le omologhe rappresentazioni nel software multibody «Adams».


- Adams
    - Realizzazione del modello multibody con 4 link e 4 giunti di cui: 3 rotoidali e 1 prismatico, il quale permette l’estensione dell’ultimo braccio;

    - Assegnazione dei motori (motions) relativi ai giunti inseriti;

    - Realizzazione della struttura del camion così da definirne le dimensioni effettive e le relative masse;

    - Inserimento di joint sferici sulle ruote per vincolare l’autocarro al ground.

## DATI PROGETTO
![image](https://github.com/user-attachments/assets/d4bca6db-4df2-452f-a7c1-c0999ae9c49d)
Obiettivo: stima della massa di ASTA 5 (carico)

## CINEMATICA DIRETTA
![image](https://github.com/user-attachments/assets/822b8571-e7e1-42d3-8941-d76bdf01af09)

La cinematica diretta permette di determinare la posizione del terminale del cinematismo noti gli spostamenti che compiono i giunti. La configurazione spaziale del robot viene definita tramite le matrici di trasformazione, le quali descrivono la posizione dei giunti in relazione alla terna di riferimento globale.
Lo studio è stato effettuato con delle variabili simboliche.
La matrice T04 consente di ottenere il vettore posizione del terminale P.

Inoltre, viene creata una function ‘DK3R1P’ che verrà utilizzata per determinare la configurazione dello spazio dei giunti.

![image](https://github.com/user-attachments/assets/04e3be94-82c1-40e1-90bb-2a8a46d6ed0c), ![image](https://github.com/user-attachments/assets/0bc3df3b-57d3-47e2-95c6-fe0dc9801083)

## SCHEMA CONFIGURAZIONE GRU
![image](https://github.com/user-attachments/assets/9d5a3c46-a193-4b8e-a8fe-ff789091087e), ![image](https://github.com/user-attachments/assets/fd8fd1ae-dd32-418f-baee-f8662a499305)


## PIANIFICAZIONE SPAZIO DEI GIUNTI
Nella pianificazione dello spazio dei giunti la traiettoria è stabilita in funzione delle variabili controllate durante il moto (giunti). Nel passare dalla configurazione iniziale a quella finale i giunti si muovono a velocità costante, percorrendo escursioni angolari costanti in intervalli di tempo costanti. La traiettoria del terminale è ottenuta come conseguenza del moto dei giunti e viene descritta da un polinomio di grado 5.  

![image](https://github.com/user-attachments/assets/627e84ed-90c3-40d8-86bc-fa45400c3f6d)
![image](https://github.com/user-attachments/assets/73f658dd-8109-4f85-9c44-ec6edf6621a2)
![image](https://github.com/user-attachments/assets/d441a499-e483-45fc-b792-6693b0030693)
![image](https://github.com/user-attachments/assets/93568986-c45a-478f-a07c-8587d3ca05c2)

## ANALISI STATICA
Tramite un’analisi statica si individua il carico massimo sollevabile dalla gru prima del ribaltamento. Sono state prese in esame quattro configurazioni principali: q1=0, q1= π/2, q1= π, q1=3/2π, considerando per ognuna la massima estensione dei bracci.  Si mostra lo script della prima configurazione, in cui si analizza l’equilibrio dei momenti intorno alle ruote: anteriore sinistra e posteriore sinistra.
- 1° configurazione (0 rad)
![image](https://github.com/user-attachments/assets/34bc3f4f-21e0-47f3-b87a-aef5c3f26e03)
![image](https://github.com/user-attachments/assets/a4b3fbef-232e-4661-8777-7fe7c63eb389)
La massa con la quale avviene il ribaltamento è m = 990 kg, ed il momento corrispondente è M = -569.0779 Nm.

- 2° configurazione (pi/2 rad)
![image](https://github.com/user-attachments/assets/f5ff9517-008e-49ca-b14b-459a2d79f415)
![image](https://github.com/user-attachments/assets/7af612cd-0fdc-4c34-b9de-8fd0dc1989f3)
La massa con la quale avviene il ribaltamento è m = 3180 kg, ed il momento corrispondente è M = -270.6219 Nm.


- 3° configurazione (pi rad)
![image](https://github.com/user-attachments/assets/9ce66da7-2219-45ac-b135-add9304c60c8)
![image](https://github.com/user-attachments/assets/64352445-c790-476b-bc02-631dbfd4b063)
La massa con la quale avviene il ribaltamento è m = 1000 kg, ed il momento corrispondente è M = -491.8556 Nm.


-4° configurazione (2pi rad)
![image](https://github.com/user-attachments/assets/2965c405-649f-4250-9633-2ad43c8a7631)
![image](https://github.com/user-attachments/assets/2739b806-d5fd-4528-80c7-1e5252d057e3)
La massa con la quale avviene il ribaltamento è m = 1200 kg, ed il momento corrispondente è M = -438.5289 Nm.
![image](https://github.com/user-attachments/assets/2d8b6598-c5f9-4b2b-96ac-300a2db8992d)


## ANALISI DINAMICA
Lo studio della dinamica è stato eseguito tramite le equazioni di Newton-Eulero, le quali permettono di ottenere le  coppie ai giunti e le reazioni vincolari scambiate tra le aste stesse o tra le aste e il telaio, una volta assegnate le posizioni, velocità e accelerazioni di tutti i membri. Al corpo da sollevare (asta 5) è stata assegnata una massa di 900 kg in modo da restare entro i limiti imposti dall’analisi statica. Si mostrano, quindi, i calcoli relativi al link 1, eseguiti analogamente anche per le altre aste, compreso telaio e peso da sollevare.
![image](https://github.com/user-attachments/assets/0ef03e34-e5e0-4ff4-9bdc-603e39eda2d6)
![image](https://github.com/user-attachments/assets/dac210ee-4c3d-4886-b841-f353c8673c8a)
![image](https://github.com/user-attachments/assets/d822944f-ac5f-4d22-afe3-bb62fd366c7d)

![image](https://github.com/user-attachments/assets/43a02cc6-3085-4b0c-8f65-ecfb588db85f)
![image](https://github.com/user-attachments/assets/21ce9038-dcc0-4819-a444-2f952575f497)


-1 intervallo
![image](https://github.com/user-attachments/assets/77c05931-0e8b-4972-bc7f-78515b01b1d6)
![image](https://github.com/user-attachments/assets/f6d25809-f44f-43fe-9d9d-8e7cc210080b)

