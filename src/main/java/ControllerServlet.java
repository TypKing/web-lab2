import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "ControllerServlet", urlPatterns = {"/control"})
public class ControllerServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log("HUI");
        String x = req.getParameter("coordinateX");
        log("HUI");
        String y = req.getParameter("coordinateY");
        String r = req.getParameter("R");
        resp.setHeader("Content-Type", "text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        log("HUINIA");
        if (x == null || y == null || r == null) req.getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
        else req.getServletContext().getRequestDispatcher("/check").forward(req, resp);
    }
}
