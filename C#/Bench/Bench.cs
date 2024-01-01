using System;
using System​.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices.Marshalling;
using System.Text;

namespace Bench
{
    public class Program
    {
        private static int num_rows = 100000;
        private static int num_cols = 10;
        private static int count = 0;
        
        private static String xx;
        /*
        private static String pid() throws IOException {
                  byte[] bo = new byte[100];
                  String[] cmd = {"bash", "-c", "echo $PPID"};
                  Process p = Runtime.getRuntime().exec(cmd);
                  p.getInputStream().read(bo);
                  String pid = new String(bo).trim();
        //        System.out.println(new String(bo));
                  return pid;
        }
        */
        private static void rss() {
                int pid = Process.GetCurrentProcess().Id;
              //  Console.WriteLine("Pid is {0}", pid);
                ProcessStartInfo cmd = new ProcessStartInfo("bash", "-c \"echo $(expr `ps -o rss= -p " + pid + "` / 1024) MB\"");
                cmd.UseShellExecute = false;
                Process p = Process.Start(cmd);
        }

        private static String multiply_string(String s, int n) {
                if (n <= 1)
                        return s;
                else
                        return s + multiply_string(s, n - 1);
        }

        private static String gen() {
                count++;
                return count.ToString() + xx;
        }
        
        private static T[] initArray<T>(int n, Func<T> g) {
                T[] array = new T[n];
              /*  for (int i=0; i < array.Length; i++) {
                        array[i] = g();
                } */
                T[] initialized = array.Select(_ => g()).ToArray();
                return initialized;
        }
/*
        private static String[][] init2DStringArray(int n, Func<String[]> g) {
                String[][] array = new String[n][];
                for (int i=0; i < array.Length; i++) {
                        array[i] = g();
                }
                return array;
        }
*/
        private static U[] mapReduce<T,U>(T[][] array, Func<T[],U> f) {
                /*U[] res = new U[array.Length];
                for (int i=0; i < array.Length; i++) {
                        res[i] = f(array[i]);
                }*/
                U[] res = array.Select(f).ToArray();
                return res;
        }
        private static String makeCSV() {
                //String[][] rows = initArray(num_rows, () => initArray(num_cols,gen));
                string[][] rows = new string[num_rows] [];
                for(int i=0; i < num_rows; i++)
                {
                        rows[i] = new string[num_cols];
                        for(int j=0; j < num_cols; j++)
                        {
                                rows[i][j] = gen();
                        }
                }
                
                Console.WriteLine(count.ToString());
                String csv = String.Join("\n", mapReduce(rows, row => String.Join(",", row)));

                rss();
                return csv;
        }

        public static void Main(string[] args)
        {
            DateTime startDate = DateTime.Now;
            //xx = multiply_string("x", 1000);
            var sb = new StringBuilder();
            for(int i=0; i<  1000; i++)
            {
                sb.Append('X');
            }
            xx = sb.ToString();

            rss();

            for (int i = 1;i<=10;i++)
            {
                Console.WriteLine(makeCSV().Length.ToString());
            }

            long elapsedTicks = DateTime.Now.Ticks - startDate.Ticks;
            TimeSpan elapsedSpan = new TimeSpan(elapsedTicks);
            Console.WriteLine("Real time is {0:N2} seconds", elapsedSpan.TotalSeconds);
        }
    }
}
