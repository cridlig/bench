import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Bench {

	private static int num_rows = 100000;
	private static int num_cols = 10;
	private static int count = 0;
	
	private static String xx;
	
	private static String pid() throws IOException {
		  byte[] bo = new byte[100];
		  String[] cmd = {"bash", "-c", "echo $PPID"};
		  Process p = Runtime.getRuntime().exec(cmd);
		  p.getInputStream().read(bo);
		  String pid = new String(bo).trim();
	//	  System.out.println(new String(bo));
		  return pid;
		}
	
	private static void rss() {
		final Runtime rt = Runtime.getRuntime();
		try {
			Process p = rt.exec(new String[]{"bash", "-c", "echo $(expr `ps -o rss= -p " + pid() + "` / 1024) MB"});
			byte[] bo = new byte[100];
			p.getInputStream().read(bo);
			System.out.println(new String(bo));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static String multiply_string(String s, int n) {
		return Stream.generate(() -> s).limit(n).collect(Collectors.joining(""));
	}
/*
	private static String makeCSV() {
		String[][] data = Stream.generate(() -> Stream.generate(() -> Integer.toString(++count) + xx).limit(num_cols).toArray(String[]::new)).limit(num_rows).toArray(String[][]::new);
    	System.out.println(Integer.toString(count));
    	rss();
    	System.gc();
    	rss();
    	String csv = String.join("\n", Arrays.stream(data).map(row -> String.join(",", row)).toArray(String[]::new));

    	rss();
    	return csv;
	}
	*/
	
	private static CompactCharSequence makeCSV() {
		CompactCharSequence[][] data = Stream.generate(() -> Stream.generate(() -> new CompactCharSequence(Integer.toString(++count) + xx)).limit(num_cols).toArray(CompactCharSequence[]::new)).limit(num_rows).toArray(CompactCharSequence[][]::new);
    	System.out.println(Integer.toString(count));
    	rss();
    	System.gc();
    	rss();
    	CompactCharSequence csv = new CompactCharSequence(String.join("\n", Arrays.stream(data).map(row -> new CompactCharSequence(String.join(",", row))).toArray(CompactCharSequence[]::new)));

    	rss();
    	return csv;
	}
	
	/*
	private static <R> List<R> generate(int size, Function<Integer, R> mapper) {

		ArrayList<R> acc = new ArrayList<R>();
		
		for(int i = 0; i < size; i++) {
			acc.add(mapper.apply(i));
		}

		return acc;
	}
	
	private static <E,R> List<R> map(List<E> list, Function<E, R> mapper) {

		ArrayList<R> acc = new ArrayList<R>();
		
		for(E element : list) {
			acc.add(mapper.apply(element));
		}

		return acc;
	}
	
	private static String makeCSV() {
		List<List<String>> data = generate(num_rows, j -> generate(num_cols, i -> Integer.toString(++count) + xx));
    	System.out.println(Integer.toString(count));
    	rss();
    	System.gc();
    	rss();
    	String csv = String.join("\n", map(data, row -> String.join(",", row)));

    	rss();
    	return csv;
	}
	*/
	public static void main(String[] args) {
		long timeBegin = new Date().getTime();

		xx = multiply_string("x", 1000);
    
		rss();

		for (int i = 1;i<=10;i++)
		{
			System.out.println(Integer.toString(makeCSV().length()));
		}

		long timeEnd = new Date().getTime();
		System.out.println("real time = " + String.format( "%.2f", (timeEnd - timeBegin)/1000.0) + "s");
	}

}
