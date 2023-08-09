PImage starImage;          // Imagen de estrella
int[] starsPerLevel = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21};  // Cantidad de estrellas por nivel
int currentLevel = 0;      // Nivel actual
int totalStars;            // Número total de estrellas en el nivel actual
int clickedStars = 0;      // Contador de estrellas contadas

float[] starX;
float[] starY;
boolean[] counted;

void setup() {
  size(800, 600);
  starImage = loadImage("star.png");  // Cargar la imagen de estrella
  textAlign(CENTER, CENTER);
  nextLevel();  // Configurar el primer nivel
}

void draw() {
  background(0);
  
  // Mostrar las imágenes de estrella
  for (int i = 0; i < totalStars; i++) {
    if (!counted[i]) {
      image(starImage, starX[i] - 15, starY[i] - 15, 30, 30);
    }
  }
  
  fill(255);
  textSize(24);
  text("¡Cuenta las estrellas haciendo clic en ellas!", width / 2, height - 30);
  text("Nivel: " + (currentLevel + 1) + "  Estrellas contadas: " + clickedStars + " de " + totalStars, width / 2, 30);
}

void mouseClicked() {
  // Verificar si se hizo clic en una estrella
  for (int i = 0; i < totalStars; i++) {
    float distance = dist(mouseX, mouseY, starX[i], starY[i]);
    if (distance < 15 && !counted[i]) {  // Si el clic está dentro del radio de la estrella
      counted[i] = true;
      clickedStars++;
      playSound();  // Reproducir un sonido al contar una estrella
      break;
    }
  }
  
  // Verificar si se completó el nivel
  if (clickedStars == totalStars) {
    currentLevel++;
    if (currentLevel < starsPerLevel.length) {
      nextLevel();
    } else {
      // Se han completado todos los niveles
      textSize(48);
      text("¡Has completado todos los niveles!", width / 2, height / 2);
    }
  }
}

void nextLevel() {
  totalStars = starsPerLevel[currentLevel];
  starX = new float[totalStars];
  starY = new float[totalStars];
  counted = new boolean[totalStars];
  
  // Generar ubicaciones aleatorias para las estrellas
  for (int i = 0; i < totalStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
  }
  
  clickedStars = 0;  // Reiniciar el contador de estrellas contadas
}

void playSound() {
  // Puedes cargar y reproducir un archivo de sonido aquí
  // Para simplificar, aquí emitiremos un pitido
  println("¡Estrella contada!");
}
