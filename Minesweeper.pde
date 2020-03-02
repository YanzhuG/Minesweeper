import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList <MSButton>(); 
Boolean valid;
int amount=0;
int minenums=30;//ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 500);
  background(122,62,72);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  buttons=new MSButton[NUM_ROWS][NUM_COLS];//your code to initialize buttons goes here
  for (int x=0; x<NUM_ROWS; x++) {
    for (int y=0; y<NUM_COLS; y++) {
      buttons[x][y]=new MSButton(x, y);
    }
  }
for (int i=0; i<minenums; i++) {
  setMines();
}
}
public void setMines()
{
  int r = (int)(Math.random()*NUM_ROWS);
  int c = (int)(Math.random()*NUM_COLS);
  if (!mines.contains(buttons[r][c]))
    mines.add(buttons[r][c]);//your code
}

public void draw ()
{
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  if(amount==minenums){
    return true;
  }//your code here
  return false;
}
public void displayLosingMessage()
{
  fill(253,175,152);
  textSize(30);
  text("You Losed, try again",190,430);//your code here
}
public void displayWinningMessage()
{
  fill(253,175,152);
  textSize(30);
  text("You Win",200,430);//your code here
}
public boolean isValid(int r, int c)
{
  if (r<NUM_ROWS&&c<NUM_COLS&&r>=0&&c>=0)
    return true;
  else //your code here
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row-1, col-1) &&  mines.contains(buttons[row-1][col-1]))
    numMines++;
  if (isValid(row-1, col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if (isValid(row-1, col+1) &&   mines.contains(buttons[row-1][col+1]))
    numMines++;
  if (isValid(row, col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if (isValid(row, col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if (isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if (isValid(row+1, col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if (isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;//your code here
  return numMines;
}
public class MSButton
{
  int a,b;
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    a=row;
    b=col;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this );// register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    isWon();
    if (mouseButton==RIGHT) {
      flagged=!flagged;
      amount++;
      if (flagged==false)
        clicked=false;
    } else if (mines.contains(this))
    {
      displayLosingMessage();
    }
    else if(countMines(a,b)>0){
     setLabel(countMines(a,b));
    }
     else {
    if(isValid(a,b-1)==true&&buttons[a][b-1].clicked==false)
    {
      buttons[a][b-1].mousePressed();
    }
    if(isValid(a-1,b-1)==true&&buttons[a-1][b-1].clicked==false)
    {
      buttons[a-1][b-1].mousePressed();
    }
    if(isValid(a+1,b-1)==true&&buttons[a+1][b-1].clicked==false)
    {
      buttons[a+1][b-1].mousePressed();
    }
    if(isValid(a,b+1)==true&&buttons[a][b+1].clicked==false)
    {
      buttons[a][b+1].mousePressed();
    }
    if(isValid(a-1,b+1)==true&&buttons[a-1][b+1].clicked==false)
    {
      buttons[a-1][b+1].mousePressed();
    }
    if(isValid(a+1,b+1)==true&&buttons[a+1][b+1].clicked==false)
    {
      buttons[a+1][b+1].mousePressed();
    }
    if(isValid(a+1,b)==true&&buttons[a+1][b].clicked==false)
    {
      buttons[a+1][b].mousePressed();
    }
    if(isValid(a-1,b)==true&&buttons[a-1][b].clicked==false)
    {
      buttons[a-1][b].mousePressed();
    }
    }//your code here
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) {
      fill(219, 97, 97);
    }
    else if (clicked)
      fill( 253,211,193 );
    else 
    fill( 253,175,152 );

    rect(x, y, width, height);
    fill(0);
    textSize(15);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
