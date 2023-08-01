import Frontend.*;
import Parser.MxLexer;
import Parser.MxParser;
import Util.Scope.*;

// import java.io.InputStream;
// import java.io.PrintStream;
// import java.io.FileInputStream;
// import java.io.FileOutputStream;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

import AST.ProgramNode;

public class Main {
  public static void main() throws Exception {
    // CharStream input = CharStreams.fromStream(new FileInputStream("input.mx"));
    CharStream input = CharStreams.fromStream(System.in);
    MxLexer lexer = new MxLexer(input);
    // lexer.removeErrorListeners();
    // lexer.addErrorListener(new MxErrorListener());
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    MxParser parser = new MxParser(tokens);
    // parser.removeErrorListeners();
    // parser.addErrorListener(new MxErrorListener());
    ParseTree tree = parser.program();
    ASTBuilder astBuilder = new ASTBuilder();
    ProgramNode ast = (ProgramNode) astBuilder.visit(tree);
    GlobalScope globalScope = new GlobalScope();
    new SymbolCollector(globalScope).visit(ast);

  }
}