## OVERTURNING ANALYSIS OF A CRANE ON A TRUCK

## OBJECTIVE
The objective of the project is to determine the overturning of a crane placed on top of a lorry, after defining the geometric data obtained from a technical data sheet of an existing crane truck; then the permissible load for the lorry not to overturn is identified.

## SOFTWARE USED

- [![MATLAB](https://img.shields.io/badge/MATLAB-FF7F00?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
    - Analysis of direct kinematics.
    - Joint space definition.
    - Static and dynamic analysis: calculation of the lifting limit mass (verification of vehicle rollover).
    - Comparison of plots obtained with homologous representations in the ‘Adams’ multibody software.

- [![Adams Multibody](https://img.shields.io/badge/Adams--Multibody-34A853?style=for-the-badge)](https://www.mscsoftware.com/product/adams)
    - Implementation of the multibody model with 4 links and 4 joints of which: 3 rotoidal and 1 prismatic, which allows the extension of the last arm.
    - Assignment of the motors (motions) relative to the inserted joints.
    - Creation of the truck structure in order to define its actual dimensions and relative masses.
    - Insertion of ball joints on the wheels to bind the truck to the ground.


<div align="center">
<img src="https://github.com/user-attachments/assets/04e3be94-82c1-40e1-90bb-2a8a46d6ed0c" alt="image3" width="400">
<img src="https://github.com/user-attachments/assets/0bc3df3b-57d3-47e2-95c6-fe0dc9801083" alt="image4" width="400">
</div>

---

## CONFIGURATION

<div align="center">
<img src="https://github.com/user-attachments/assets/9d5a3c46-a193-4b8e-a8fe-ff789091087e" alt="image5" width="400">
<img src="https://github.com/user-attachments/assets/fd8fd1ae-dd32-418f-baee-f8662a499305" alt="image6" width="400">
</div>

---

## JOINT SPACE PLANNING

In joint space planning, the trajectory is established as a function of the variables controlled during the motion (joints). In moving from the initial to the final configuration, the joints move at constant speed, covering constant angular excursions in constant time intervals. The terminal trajectory is obtained as a consequence of the joint motion and is described by a polynomial of degree 5.

<div align="center">
<table>
<tr>
<td><img src="https://github.com/user-attachments/assets/73f658dd-8109-4f85-9c44-ec6edf6621a2" alt="image8" width="300"></td>
<td><img src="https://github.com/user-attachments/assets/d441a499-e483-45fc-b792-6693b0030693" alt="image9" width="300"></td>
</tr>
</table>
</div>
<div align="center">
<img src="https://github.com/user-attachments/assets/bf5bd090-e334-4259-af82-9d5e48f09db9" alt="image8" width="300">
</div>

---

## STATIC ANALYSIS

A static analysis identifies the maximum load that can be lifted by the crane before overturning. Four main configurations were considered: **q1=0**, **q1= π/2**, **q1= π**, **q1= 3/2π**, considering for each the maximum extension of the arms.

### 1° Configuration (0 rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/34bc3f4f-21e0-47f3-b87a-aef5c3f26e03" alt="image11" width="400">
<img src="https://github.com/user-attachments/assets/a4b3fbef-232e-4661-8777-7fe7c63eb389" alt="image12" width="400">
</div>
**m = 990 kg**, **M = -569.0779 Nm**

### 2° Configuration (π/2 rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/f5ff9517-008e-49ca-b14b-459a2d79f415" alt="image13" width="400">
<img src="https://github.com/user-attachments/assets/7af612cd-0fdc-4c34-b9de-8fd0dc1989f3" alt="image14" width="400">
</div>
**m = 3180 kg**, **M = -270.6219 Nm**.

### 3° Configuration (π rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/9ce66da7-2219-45ac-b135-add9304c60c8" alt="image15" width="400">
<img src="https://github.com/user-attachments/assets/64352445-c790-476b-bc02-631dbfd4b063" alt="image16" width="400">
</div>
**m = 1000 kg**, **M = -491.8556 Nm**

### 4° Configuration (2π rad)
<div align="center">
<img src="https://github.com/user-attachments/assets/2965c405-649f-4250-9633-2ad43c8a7631" alt="image17" width="400">
<img src="https://github.com/user-attachments/assets/2739b806-d5fd-4528-80c7-1e5252d057e3" alt="image18" width="400">
</div>
**m = 1200 kg**, **M = -438.5289 Nm**.

---

## DYNAMIC ANALYSIS

The study of the dynamics was performed using the Newton-Euler equations, which allow obtaining the torques at the joints and the constraint reactions exchanged between the rods themselves or between the rods and the frame.

### Trajectory intervals
1st interval
<div align="center">
<img src="https://github.com/user-attachments/assets/f6d25809-f44f-43fe-9d9d-8e7cc210080b" alt="image19" width="400">
</div>
2nd interval
<div align="center">
<img src="https://github.com/user-attachments/assets/02726afa-8e99-455c-bfad-48c7dc1f0fac" alt="image20" width="400">
</div>
3rd interval
<div align="center">
<img src="https://github.com/user-attachments/assets/01cfe465-93b6-4884-8b24-2bac41b8b2b9" alt="image21" width="400">
</div>
4th interval
<div align="center">
<img src="https://github.com/user-attachments/assets/f656727a-97d6-458a-87b5-a1ccb3784e47" alt="image22" width="400">
</div>

Considering the trajectory traveled, divided into the intervals described, the constraint reactions between the ground and the truck are defined. As shown in the following graphs, the forces all have a positive value, confirming the fact that the truck does not overturn.
<div align="center">
<img src="https://github.com/user-attachments/assets/50ab94b8-1e32-4928-9c83-bb5074c39855" alt="image23" width="400">
</div>

---

## CASE STUDY: Front left wheel constraint analysis

### Variation of the mass of the load applied to the crane
<div align="center">
<img src="https://github.com/user-attachments/assets/40aeb178-6547-4c8b-bdee-f28cd3d400e4" alt="image24" width="400">
<img src="https://github.com/user-attachments/assets/ef95f0b3-ab61-417f-8f70-5d3edc143733" alt="image25" width="400">
</div>

### PLOTS
<div align="center">
<img src="https://github.com/user-attachments/assets/84807e28-2cf7-4e13-b4c3-c910f3a4625d" alt="image26" width="400">
</div>

## Member
Veronica Ilari
