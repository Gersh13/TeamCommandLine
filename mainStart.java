import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import java.io.IOException;

import static org.antlr.v4.runtime.CharStreams.fromFileName;



public class mainStart {
    public static void main(String[] args) {
        try {
            String py_file = "src/python_test_code.py";

            CharStream charStrm = fromFileName(py_file);

            grammarForPythonLexer lexer = new grammarForPythonLexer(charStrm);

            CommonTokenStream token = new CommonTokenStream(lexer);

            grammarForPythonParser parser = new grammarForPythonParser(token);

            ParseTree tree = parser.start();

            grammarControl control = new grammarControl();

            control.visit(tree);
        }
        catch(IOException e) {
            e.printStackTrace();
        }
    }
}
