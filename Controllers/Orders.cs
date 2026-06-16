using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Webproject.Data;
using Webproject.Models;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace Webproject.Controllers
{
    public class OrdersController : Controller
    {
        private readonly ApplicationDbContext _context;

        public OrdersController(ApplicationDbContext context)
        {
            _context = context;
        }


        [HttpPost]
        public IActionResult ConfirmOrder(List<int> selectedProducts)
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null) return RedirectToAction("SignIn", "Account");

            if (selectedProducts == null || selectedProducts.Count == 0)
                return RedirectToAction("Index", "Products");

            var products = _context.Products
                .Where(p => selectedProducts.Contains(p.Id))
                .ToList();

            var total = products.Sum(p => p.Price);

            var order = new Order
            {
                UserId = userId.Value,
                OrderDate = DateTime.Now,
                TotalPrice = total
            };

            _context.Orders.Add(order);
            _context.SaveChanges();

            foreach (var product in products)
            {
                _context.OrderDetails.Add(new OrderDetail
                {
                    OrderId = order.Id,
                    ProductId = product.Id,
                    Price = product.Price
                });
            }

            _context.SaveChanges();
            return RedirectToAction("Success", new { id = order.Id });
        }

        // عرض طلبات المستخدم الحالي فقط
        public IActionResult MyOrders()
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null) return RedirectToAction("SignIn", "Account");

            var orders = _context.Orders
                .Where(o => o.UserId == userId.Value)
                .OrderByDescending(o => o.OrderDate)
                .ToList();

            return View(orders);
        }

        public IActionResult Details(int id)
        {
            var userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null) return RedirectToAction("SignIn", "Account");

            var order = _context.Orders.FirstOrDefault(o => o.Id == id && o.UserId == userId);
            if (order == null) return NotFound();

            var orderDetails = _context.OrderDetails
                .Include(od => od.Product)
                .Where(od => od.OrderId == id)
                .ToList();

            return View(orderDetails);
        }

        public IActionResult Success(int id)
        {
            var productIds = _context.OrderDetails
                .Where(od => od.OrderId == id)
                .Select(od => od.ProductId)
                .ToList();

            var products = _context.Products
                .Where(p => productIds.Contains(p.Id))
                .ToList();

            ViewBag.Products = products;

            ViewBag.Total = _context.OrderDetails
                .Where(od => od.OrderId == id)
                .Sum(od => od.Price);

            return View();
        }

        public IActionResult DeleteOrder(int id)
        {
            var order = _context.Orders.FirstOrDefault(o => o.Id == id);

            if (order == null)
                return NotFound();

            var details = _context.OrderDetails
                .Where(x => x.OrderId == id)
                .ToList();

            _context.OrderDetails.RemoveRange(details);
            _context.Orders.Remove(order);

            _context.SaveChanges();

            return RedirectToAction("MyOrders");
        }
    }
}