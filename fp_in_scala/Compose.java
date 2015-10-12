import java.util.function.Function;

// I wanted to see, for comparison, what a compose function in 
// java8 would look like. It's a chapter 2 problem in scala.

public class Compose {
  
   private static  <A,B,C> Function<A,C> 
      compose(Function<B,C> g, Function<A,B> f) {
        return f.andThen(g);
   }

   public static void main(String[] args) {
      Function<String,Integer> fxlen = compose(String::length, (s) -> s + " .. ");
      System.out.println(" it is " + fxlen.apply("what").toString());
   }
}
