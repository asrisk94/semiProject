package product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.service.BasketService;

/**
 * Servlet implementation class BasketAmountAjaxServlet
 */
@WebServlet("/product/basketAmountAjax")
public class BasketAmountAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int basketAmount = Integer.parseInt(request.getParameter("basketAmount"));
		int basketNum = Integer.parseInt(request.getParameter("basketNum"));
		
		int result = new BasketService().basketAmountAjax(basketAmount, basketNum);
		
		response.getWriter().print(result);
		
	}

}
