// Created with "Processing":https://processing.org
// Red Kirlian Mandelbrot
// MandelbrotSetModoki_2.0
// https://www.openprocessing.org/sketch/446828
// fork by Rupert Russell


int N = 500 ; 
float L = 0.01 ; 
float AA = 0.5 ; 
int IImax = 100 ; 
float Zmax = 1000 ;
float Xmin = -2 ; 
float Ymin= -1.5 ; 
float Xmax = +1 ; 
float Ymax = +1.5 ;

float NX ; 
float NY ; 
float X ; 
float Y ; 
float KX ; 
float KY ;
float CX[] = new float[N] ; 
float CY[] = new float[N] ; 
float CA[] = new float[N] ; 
float D[] = new float[N] ;  
int COL[] = new int[N] ; 
int MODE[] = new int[N] ;
float KD ; 
float KDR ; 
float KDL ; 
int I ; 
int II ; 
int B = 1 ; 
int DON ; 
int KI ; 
int KIL ; 
int KIR ;

int scale = 770;
int counter = 0;
int saveCounter = 0;


void setup() {

  size(770, 770) ;
  noSmooth() ;
  strokeWeight(2) ;
  background(0, 0, 0) ;

  // for ( I = 0 ; I < N ; I++ ){ MODE[I] = 0 ; }
} // stup()



void draw() {

  saveCounter ++;
  
  if(saveCounter == 10000){
  saveimage();
  saveCounter = 0; 
  }
  
  

  for ( I = 0; I < N; I++ ) {

    if ( MODE[I] == 1 ) {
      DON = 1 ;
      KX = CX[I] + (L*cos(CA[I]-AA)) ; 
      KY = CY[I] + (L*sin(CA[I]-AA)) ;
      DIVERGEorNOT() ; 
      KDL = KD ; 
      KIL = KI ;
      KX = CX[I] + (L*cos(CA[I]+AA)) ; 
      KY = CY[I] + (L*sin(CA[I]+AA)) ;
      DIVERGEorNOT() ; 
      KDR = KD ; 
      KIR = KI ;
      if ( ( KDL > KDR && KIL == KIR ) || KIL < KIR ) { 
        CA[I] = CA[I]-AA ;
      }
      if ( ( KDL < KDR && KIL == KIR ) || KIL > KIR ) { 
        CA[I] = CA[I]+AA ;
      }
      if ( KDL == KDR && KIL == KIR ) { 
        CA[I] = CA[I] ;
      }
      NX = CX[I] + (L*cos(CA[I])) ;
      NY = CY[I] + (L*sin(CA[I])) ;
      if ( DON == 0 ) { 
        stroke(COL[I], 0, 0, 25) ;  
        line((CX[I]-Xmin)* scale/(Xmax-Xmin), (CY[I]-Ymin)* scale/(Ymax-Ymin), (NX-Xmin)* scale/(Xmax-Xmin), (NY-Ymin)* scale/(Ymax-Ymin)) ;
      }
      CX[I] = NX ; 
      CY[I] = NY ; 
      if ( COL[I] > 0 && DON == 0 ) { 
        COL[I] = COL[I] - 2 ;
      } else { 
        MODE[I] = 0 ;
      }
    }

    if ( MODE[I] == 0 ) {
      Cset() ;
      if ( DON == 1 ) { 
        MODE[I] = 1 ;
      }
    }
  }
} // DRAW()



void Cset() {

  CX[I] = (Xmax-Xmin)*int(random(0, 700))/700 + Xmin ;
  CY[I] = (Ymax-Ymin)*int(random(0, 700))/700 + Ymin ;
  CA[I] = random(-PI, +PI) ;
  KX = CX[I] ; 
  KY = CY[I] ;
  DIVERGEorNOT() ; 
  D[I] = KD ;
  COL[I] = 255 ;
} // Cset



void DIVERGEorNOT() {

  X = 0 ; 
  Y = 0 ; 
  DON = 1 ;

  for ( II = 0; II < IImax; II++ ) {
    NX = (X*X)-(Y*Y)+KX ; 
    NY = (2*X*Y)+KY ;
    X = NX ; 
    Y = NY ;
    KD = sqrt((X*X)+(Y*Y)) ;
    KI = II ;
    if ( KD > Zmax ) { 
      DON = 0 ; 
      II = IImax ;
    }
  }
} // DIVERGEorNOT



void mousePressed() {
saveimage();
} // mousePressed()


void saveimage(){
  
    counter++;
  println("about to save " + counter);
  save("mandelbrot_7_" + counter + ".png");
  println("saved " + counter);
}
