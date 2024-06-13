import java.util.Scanner;

public class Main {

    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        
        int cnt = sc.nextInt();
        sc.nextLine();
        int XX = 0;
        int YY = 0;
        int[] arr = new int[cnt];
        
        for(int i=0; i<cnt; i++) {
        	
        	String temp = sc.nextLine();
        	String[] tempArr = temp.split(" ");
        	int Y = Integer.parseInt(tempArr[0]);
        	int X = Integer.parseInt(tempArr[1]);
        	int cus = Integer.parseInt(tempArr[2]);
        	// 받아주기
        	
        	if(cus%Y == 0) {
        		XX = Y*100;
        		YY = (cus/Y);
        	}else {
        		XX = (cus%Y)*100;
        		YY = ((cus/Y)+1);
        	}
        	arr[i] = XX+YY;
        }
        
        for(int j=0; j<cnt; j++) {
        	System.out.println(arr[j]);
        }
    }
}
