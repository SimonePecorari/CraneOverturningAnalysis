## ANALISI RIBALTAMENTO DI UNA GRU SU UN AUTOCARRO

## OBIETTIVO
L’obiettivo del progetto è determinare il ribaltamento di una gru posta sopra un autocarro, dopo aver definito i dati geometrici ottenuti da una scheda tecnica di un’autogrù già esistente; quindi si va ad individuare il carico ammissibile affinché l’autocarro non si ribalti.

## SOFTWARE UTILIZZATI

- [![MATLAB](https://img.shields.io/badge/MATLAB-FF7F00?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
    - Analisi della cinematica diretta.
    - Definizione dello spazio dei giunti.
    - Analisi statica e dinamica: calcolo della massa limite di sollevamento (verifica del ribaltamento del mezzo).
    - Confronto dei plot ottenuti con le omologhe rappresentazioni nel software multibody «Adams».

- [![Adams Multibody](https://img.shields.io/badge/Adams--Multibody-34A853?style=for-the-badge)](https://www.mscsoftware.com/product/adams)
    - Realizzazione del modello multibody con 4 link e 4 giunti di cui: 3 rotoidali e 1 prismatico, il quale permette l’estensione dell’ultimo braccio.
    - Assegnazione dei motori (motions) relativi ai giunti inseriti.
    - Realizzazione della struttura del camion così da definirne le dimensioni effettive e le relative masse.
    - Inserimento di joint sferici sulle ruote per vincolare l’autocarro al ground.

## DATI PROGETTO
<div align="center">
 <img src="https://github.com/user-attachments/assets/d4bca6db-4df2-452f-a7c1-c0999ae9c49d" alt="image1" width="400">
</div>

**Obiettivo:** stima della massa di ASTA 5 (carico).

---

## CINEMATICA DIRETTA

<div align="center">
<img src="https://github.com/user-attachments/assets/822b8571-e7e1-42d3-8941-d76bdf01af09" alt="image2" width="400">
</div>

La cinematica diretta permette di determinare la posizione del terminale del cinematismo noti gli spostamenti che compiono i giunti. La configurazione spaziale del robot viene definita tramite le matrici di trasformazione, le quali descrivono la posizione dei giunti in relazione alla terna di riferimento globale.

Lo studio è stato effettuato con delle variabili simboliche. La matrice **T04** consente di ottenere il vettore posizione del terminale **P**. Inoltre, viene creata una funzione `DK3R1P` che verrà utilizzata per determinare la configurazione dello spazio dei giunti.

<div align="center">
<img src="https://github.com/user-attachments/assets/04e3be94-82c1-40e1-90bb-2a8a46d6ed0c" alt="image3" width="400">
<img src="https://github.com/user-attachments/assets/0bc3df3b-57d3-47e2-95c6-fe0dc9801083" alt="image4" width="400">
</div>

---

## SCHEMA CONFIGURAZIONE GRU

<div align="center">
<img src="https://github.com/user-attachments/assets/9d5a3c46-a193-4b8e-a8fe-ff789091087e" alt="image5" width="400">
<img src="https://github.com/user-attachments/assets/fd8fd1ae-dd32-418f-baee-f8662a499305" alt="image6" width="400">
</div>

---

## PIANIFICAZIONE SPAZIO DEI GIUNTI

Nella pianificazione dello spazio dei giunti la traiettoria è stabilita in funzione delle variabili controllate durante il moto (giunti). Nel passare dalla configurazione iniziale a quella finale, i giunti si muovono a velocità costante, percorrendo escursioni angolari costanti in intervalli di tempo costanti. La traiettoria del terminale è ottenuta come conseguenza del moto dei giunti e viene descritta da un polinomio di grado 5.

<div align="center">
<table>
<tr>
<td><img src="https://github.com/user-attachments/assets/73f658dd-8109-4f85-9c44-ec6edf6621a2" alt="image8" width="300"></td>
<td><img src="https://github.com/user-attachments/assets/d441a499-e483-45fc-b792-6693b0030693" alt="image9" width="300"></td>
</tr>
<tr>
</table>
</div>
<div align="center">
<img src="https://github.com/user-attachments/assets/bf5bd090-e334-4259-af82-9d5e48f09db9" alt="image8" width="300">
</div>

---

## ANALISI STATICA

Tramite un’analisi statica si individua il carico massimo sollevabile dalla gru prima del ribaltamento. Sono state prese in esame quattro configurazioni principali: **q1=0**, **q1= π/2**, **q1= π**, **q1= 3/2π**, considerando per ognuna la massima estensione dei bracci.

### 1° Configurazione (0 rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/34bc3f4f-21e0-47f3-b87a-aef5c3f26e03" alt="image11" width="400">
<img src="https://github.com/user-attachments/assets/a4b3fbef-232e-4661-8777-7fe7c63eb389" alt="image12" width="400">
</div>
La massa con la quale avviene il ribaltamento è **m = 990 kg**, ed il momento corrispondente è **M = -569.0779 Nm**.

### 2° Configurazione (π/2 rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/f5ff9517-008e-49ca-b14b-459a2d79f415" alt="image13" width="400">
<img src="https://github.com/user-attachments/assets/7af612cd-0fdc-4c34-b9de-8fd0dc1989f3" alt="image14" width="400">
</div>
La massa con la quale avviene il ribaltamento è **m = 3180 kg**, ed il momento corrispondente è **M = -270.6219 Nm**.

### 3° Configurazione (π rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/9ce66da7-2219-45ac-b135-add9304c60c8" alt="image15" width="400">
<img src="https://github.com/user-attachments/assets/64352445-c790-476b-bc02-631dbfd4b063" alt="image16" width="400">
</div>
La massa con la quale avviene il ribaltamento è **m = 1000 kg**, ed il momento corrispondente è **M = -491.8556 Nm**.

### 4° Configurazione (2π rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/2965c405-649f-4250-9633-2ad43c8a7631" alt="image17" width="400">
<img src="https://github.com/user-attachments/assets/2739b806-d5fd-4528-80c7-1e5252d057e3" alt="image18" width="400">
</div>
La massa con la quale avviene il ribaltamento è **m = 1200 kg**, ed il momento corrispondente è **M = -438.5289 Nm**.

---

## ANALISI DINAMICA

Lo studio della dinamica è stato eseguito tramite le equazioni di Newton-Eulero, le quali permettono di ottenere le coppie ai giunti e le reazioni vincolari scambiate tra le aste stesse o tra le aste e il telaio. 

### Intervalli di traiettoria
1° intervallo
<div align="center">
<img src="https://github.com/user-attachments/assets/f6d25809-f44f-43fe-9d9d-8e7cc210080b" alt="image19" width="400">
</div>
2° intervallo
<div align="center">
<img src="https://github.com/user-attachments/assets/02726afa-8e99-455c-bfad-48c7dc1f0fac" alt="image20" width="400">
</div>
3° intervallo
<div align="center">
<img src="https://github.com/user-attachments/assets/01cfe465-93b6-4884-8b24-2bac41b8b2b9" alt="image21" width="400">
</div>
4° intervallo
<div align="center">
<img src="https://github.com/user-attachments/assets/f656727a-97d6-458a-87b5-a1ccb3784e47" alt="image22" width="400">
</div>

Considerando la traiettoria percorsa, suddivisa negli intervalli descritti, si definiscono le reazioni vincolari tra terreno ed autocarro. Come mostrato nei grafici seguenti, le forze hanno tutte un valore positivo, a conferma del fatto che il camion non subisce ribaltamenti.

<div align="center">
<img src="https://github.com/user-attachments/assets/50ab94b8-1e32-4928-9c83-bb5074c39855" alt="image23" width="400">
</div>

---

## CASE STUDY: Analisi del vincolo su ruota anteriore sinistra

### Variazione della massa del carico applicato alla gru
<div align="center">
<img src="https://github.com/user-attachments/assets/40aeb178-6547-4c8b-bdee-f28cd3d400e4" alt="image24" width="400">
<img src="https://github.com/user-attachments/assets/ef95f0b3-ab61-417f-8f70-5d3edc143733" alt="image25" width="400">
</div>

### PLOT ottenuti
<div align="center">
<img src="https://github.com/user-attachments/assets/84807e28-2cf7-4e13-b4c3-c910f3a4625d" alt="image26" width="400">
</div>

## Member
Veronica Ilari
