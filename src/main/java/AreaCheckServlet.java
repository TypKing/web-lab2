import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import helpfulClasses.Point;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;

@WebServlet(name = "AreaCheckServlet", urlPatterns = {"/check"})
public class AreaCheckServlet extends HttpServlet {
    ArrayList<Point> points = null;
    HttpSession session;


    @Override
    public void destroy() {
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        session = req.getSession();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        long startTime = new Date().getTime();
        PrintWriter printWriter = resp.getWriter();

        if (points == null) {
            points = new ArrayList<Point>();
            session.setAttribute("session", points);
        }

        Point currentPoint;

        try {
            currentPoint = new Point(Integer.parseInt(req.getParameter("coordinateX")), Double.parseDouble(req.getParameter("coordinateY")),
                    Double.parseDouble(req.getParameter("R")));
        } catch (NumberFormatException e) {
            currentPoint = null;
        }
        if (validation(currentPoint)) {
            log("Complete");
            if (check(currentPoint)) {
                currentPoint.setResult(true);
            } else currentPoint.setResult(false);
            points.add(currentPoint);
        } else {
            log("Uncomplete");
            currentPoint = null;
        }

        req.setAttribute("currentPoint", currentPoint);
        long endTime = new Date().getTime();
        if (currentPoint != null) {
            currentPoint.setDuration(endTime - startTime);
        }
        log("HUI");
        if(currentPoint!=null) {
            log(currentPoint.toString());
        }
        req.getRequestDispatcher("areaChecked.jsp").include(req, resp);
    }


    private boolean validation(Point point) {
        log("Start");
        if (point == null) return false;
        log("Start2");
        int x = point.getX();
        double y = point.getY();
        double r = point.getR();
        log("Start3");
        HashSet<Integer> x_values = new HashSet<Integer>(Arrays.asList(-4, -3, -2, -1, 0, 1, 2, 3, 4));
        HashSet<Double> r_values = new HashSet<Double>(Arrays.asList(1d, 1.5d, 2d, 2.5d, 3d));
        log("Start4");
        return (y <= 3 && y >= -5 && x_values.contains(x) && r_values.contains(r));

    }

    private boolean check(Point point) {
        LocalDateTime time = LocalDateTime.now();
        point.setTime(DateTimeFormatter.ofPattern("HH:mm:ss").format(time));
        int x = point.getX();
        double y = point.getY();
        double r = point.getR();
        return ((y >= 0 && x >= 0 && (y * y + x * x <= r * r / 4)) || (y <= 0 && x >= 0 && (y >= x - r / 2)) || (x <= 0 && y <= 0 && x >= -r / 2 && y >= -r));
    }
}