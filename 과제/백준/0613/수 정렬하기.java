import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);
		StringBuilder sbd = new StringBuilder();
		int N = sc.nextInt();
		
		ArrayList<Integer> alist = new ArrayList<>();
	
		for(int i = 0; i < N; i++) {
			alist.add(sc.nextInt());
		}
		
		Collections.sort(alist);

		for(Integer j : alist) {
			sbd.append(j).append('\n');
		}
		
		System.out.println(sbd);
	}
}
