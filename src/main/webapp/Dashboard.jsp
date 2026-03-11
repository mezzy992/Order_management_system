<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Seller Dashboard</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  
  <style>
    #topSellingCarousel .carousel-item:hover {
      transform: scale(1.04);
      box-shadow: 0 8px 25px rgba(246, 178, 225, 0.6);
    }
  </style>

  <style>

    /*  All over */
body {
  background: #f9f9fb;   /* Light gray-white background */
  font-family: 'Segoe UI', sans-serif;
  color: #222;           /* Dark text for readability */
  margin: 0;
  padding: 0;
  overflow-x: hidden;
}
    
    /* ✅ Force SELLER Registration heading to white */
    .form-container h2 {
      color: #fff !important;
      -webkit-text-fill-color: #fff !important;
      background: none !important;
      text-shadow: none;
    }

    /*  LEFT SIDEBAR */
    .sidebar {
      width: 250px;
      background: linear-gradient(180deg, #58126A, #F6B2E1);
      position: fixed;
      top: 0;
      left: 0;
      height: 100%;
      padding: 20px;
      padding-top: 70px;
      transition: width 0.3s ease;
      overflow: hidden;
      box-shadow: 2px 0 15px rgba(0,0,0,0.6);
      border-radius: 0 20px 20px 0;
    }
    /* SIDEBAR TITLE */
    .sidebar h3 {
      text-align: center;
      margin-bottom: 40px;
      font-size: 1.6rem;
      color: #fff;
      text-shadow: 0 2px 8px rgba(0,0,0,0.6);
      padding-top: 0px;
   }
       /* SIDEBAR MENU ITEMS */
    .sidebar a {
      display: flex;
      align-items: center;
      padding: 12px 15px;
      text-decoration: none;
      color: #fff;
      font-size: 1.1rem;
      margin: 10px 0;
      border-radius: 12px;
      transition: all 0.3s ease;
    }
    .sidebar a:hover, .sidebar a.active {
      background: rgba(255,255,255,0.2);
      transform: translateX(6px);
      font-weight: 600;
    }
    .sidebar a i { margin-right: 12px; transition: transform 0.3s ease; }
    .sidebar a:hover i { transform: scale(1.2); }
    .sidebar.collapsed { width: 80px; }
    .sidebar.collapsed h3, .sidebar.collapsed a span { display: none; }
    .sidebar.collapsed a { justify-content: center; }
    .sidebar.collapsed a i { margin-right: 0; }

    /* CONTENT */
    .content {
      margin-left: 260px;
      padding: 30px;
      transition: margin-left 0.3s ease;
    }
    .content.expanded { margin-left: 100px; }

    /*TOGGLE BUTTON */
    .toggle-btn {
      position: fixed;
      top: 15px;
      left: 15px;
      background: linear-gradient(90deg, #58126A, #F6B2E1);
      color: white;
      border: none;
      border-radius: 8px;
      padding: 8px 12px;
      font-size: 18px;
      cursor: pointer;
      z-index: 1000;
      box-shadow: 0 3px 10px rgba(0,0,0,0.4);
      transition: transform 0.3s;
    }
    .toggle-btn:hover { transform: scale(1.1); }

    /* WELCOME BANNER */ 
    .welcome-banner {
      background: linear-gradient(135deg, #58126A, #F6B2E1);
      padding: 25px;
      border-radius: 20px;
      box-shadow: 0 8px 25px rgba(0,0,0,0.6);
      margin-bottom: 30px;
      text-align: left;
      color: #fff;
      animation: fadeInDown 1s ease-in-out;
    }
    /* CARDS*/
    .card {
  background: rgba(255, 255, 255, 0.9);  /* Solid light card */
  backdrop-filter: blur(5px);
  border: none;
  border-radius: 20px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  color: #333; /* Darker text for light bg */
}
.card:hover {
  transform: translateY(-8px) scale(1.03);
  box-shadow: 0 12px 25px rgba(246, 178, 225, 0.3);
}
    
    .card-icon { font-size: 3rem; color: #F6B2E1; }

    /*  TABLE  */
    .table { border-radius: 12px; overflow: hidden; background: rgba(255,255,255,0.05); }
    .table thead { background: linear-gradient(135deg, #58126A, #F6B2E1); color: #fff; }
    .table tbody tr:hover { background: rgba(246, 178, 225, 0.15); cursor: pointer; }

    /*CAROUSEL */
    .carousel-item {
      transition: transform 0.5s ease-in-out, box-shadow 0.3s;
    }
    .carousel-item:hover {
      transform: scale(1.03);
      box-shadow: 0 0 15px rgba(246, 178, 225, 0.4);
    }
    
    .todo-list {
  list-style: none;
  padding: 0;
}

.todo-list li {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
  font-size: 16px;
}

.todo-list input[type="checkbox"] {
  margin-right: 10px;
  transform: scale(1.2);
  cursor: pointer;
}

/* Line-through animation */
.todo-list label {
  position: relative;
  cursor: pointer;
  transition: color 0.3s ease;
}

.todo-list input[type="checkbox"]:checked + label {
  color: #888;
}

.todo-list input[type="checkbox"]:checked + label::after {
  content: "";
  position: absolute;
  left: 0;
  top: 50%;
  width: 100%;
  height: 2px;
  background: #ff4d4d;  /* red strike color */
  transform: scaleX(0);
  transform-origin: left;
  animation: strike 0.4s forwards;
}

@keyframes strike {
  to {
    transform: scaleX(1);
  }
}
    

    /*FOOTER */
    footer {
      margin-top: 40px;
      padding: 15px 0;
      background: linear-gradient(90deg, #58126A, #F6B2E1);
      color: white;
      border-radius: 15px 15px 0 0;
      text-shadow: 0 0 4px rgba(0,0,0,0.6);
      text-align: center;
    }

    /* ANIMATIONS for fade in and out */
    @keyframes fadeInDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
     .card-icon {
    font-size: 2.5rem;
    color: #0d6efd;
  }
  .card {
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }
  .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.1);
  }
  canvas {
    height: 50px !important;
  }
  </style>
</head>
<body>

  <!-- Toggle Button -->
  <button class="toggle-btn" onclick="toggleSidebar()"><i class="bi bi-list"></i></button>

  <!-- Sidebar -->
  <div id="sidebar" class="sidebar d-inline-block">
    <h3>🌟 Seller</h3>
    <a href="Dashboard.jsp" class="active"><i class="bi bi-speedometer2"></i><span> Dashboard</span></a>
    <a href="ProductServlet"><i class="bi bi-box-seam"></i><span> Products</span></a>
    <a href="OrderServlet"><i class="bi bi-bag-check"></i><span> Orders</span></a>
    <a href="ReportedProductServlet"><i class="bi bi-flag"></i><span> Reported</span></a>
    <a href="ProfileServlet"><i class="bi bi-person-circle"></i><span> Profile</span></a>
  
    <a href="Login.jsp"><i class="bi bi-box-arrow-right"></i><span> Logout</span></a>
  </div>


  <!-- Main Content -->
  <div id="content" class="content">
    <!-- Welcome Banner -->
    <div class="welcome-banner">
      <h2>👋 Welcome back, <b>Seller!</b></h2>
      <p>Here’s an overview of your store performance today 🚀</p>
    </div>

    <!-- Main Cards -->
   <div class="row g-4">
  <!-- Total Products -->
  <div class="col-md-4 col-sm-6 col-12">
    <div class="card p-3">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h5>Total Products</h5>
            <div class="d-flex align-items-center">
              <h2 id="totalProducts"></h2>
              <span class="text-success ms-2">
                <i class="bi bi-graph-up"></i> +12%
              </span>
            </div>
          </div>
          <i class="bi bi-box card-icon"></i>
        </div>
        <canvas id="productsChart"></canvas>
      </div>
    </div>
  </div>

  <!-- Total Orders -->
  <div class="col-md-4 col-sm-6 col-12">
    <div class="card p-3">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h5>Total Orders</h5>
            <div class="d-flex align-items-center">
              <h2 id="totalOrders"></h2>
              <span class="text-success ms-2">
                <i class="bi bi-graph-up"></i> +8%
              </span>
            </div>
          </div>
          <i class="bi bi-cart-check card-icon"></i>
        </div>
        <canvas id="ordersChart"></canvas>
      </div>
    </div>
  </div>

  <!-- Reported Products -->
  <div class="col-md-4 col-sm-6 col-12">
    <div class="card p-3">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h5>Reported Products</h5>
            <div class="d-flex align-items-center">
              <h2 id="reportedProducts"></h2>
              <span class="text-danger ms-2">
                <i class="bi bi-graph-down"></i> +2%
              </span>
            </div>
          </div>
          <i class="bi bi-exclamation-triangle card-icon"></i>
        </div>
        <canvas id="reportedChart"></canvas>
      </div>
    </div>
  </div>
</div>
   <script>
  // Mini sparkline charts data
  const chartOptions = {
    plugins: { legend: { display: false }},
    scales: { x: { display: false }, y: { display: false }},
    elements: { point: { radius: 0 }},
    tension: 0.3
  };

  new Chart(document.getElementById("productsChart"), {
    type: "line",
    data: {
      labels: ["Mon","Tue","Wed","Thu","Fri"],
      datasets: [{ data: [100,110,115,118,120], borderColor: "#0d6efd", fill: false }]
    },
    options: chartOptions
  });

  new Chart(document.getElementById("ordersChart"), {
    type: "line",
    data: {
      labels: ["Mon","Tue","Wed","Thu","Fri"],
      datasets: [{ data: [70,72,75,80,85], borderColor: "#198754", fill: false }]
    },
    options: chartOptions
  });

  new Chart(document.getElementById("reportedChart"), {
    type: "line",
    data: {
      labels: ["Mon","Tue","Wed","Thu","Fri"],
      datasets: [{ data: [3,4,5,5,5], borderColor: "#dc3545", fill: false }]
    },
    options: chartOptions
  });
</script>
   
 <!-- Top Selling Carousel -->
<div class="card mt-5 p-3">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="fw-bold">Top Selling Gadgets</h4>
    <a href="ProductServlet" class="btn btn-primary btn-sm">See All Products</a>
  </div>

  <div id="topSellingCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
      
      <!-- Item 1 -->
      <div class="carousel-item active">
        <div class="d-flex align-items-center p-3 border rounded" 
             style="background: rgba(88, 18, 106,0.2); backdrop-filter: blur(12px); transition: transform 0.3s, box-shadow 0.3s;">
          <img src="images/iphone.png" 
               class="rounded me-3" 
               width="140" height="100" 
               style="object-fit: contain;" 
               alt="iPhone">
          <div class="flex-grow-1">
            <h6 class="mb-1" style="color:#F6B2E1;">Apple iPhone 15 Pro Max</h6>
            <p class="mb-0 text-white-50">8,542 Sales</p>
            <small class="text-success">✔ Available - 50 Stocks Remaining</small>
          </div>
        </div>
      </div>

      <!-- Item 2 -->
      <div class="carousel-item">
        <div class="d-flex align-items-center p-3 border rounded"
             style="background: rgba(88, 18, 106,0.2); backdrop-filter: blur(12px); transition: transform 0.3s, box-shadow 0.3s;">
          <img src="images/Laptop.png" 
               class="rounded me-3" 
               width="140" height="100" 
               style="object-fit: contain;" 
               alt="Laptop">
          <div class="flex-grow-1">
            <h6 class="mb-1" style="color:#F6B2E1;">Dell XPS 13 Ultrabook</h6>
            <p class="mb-0 text-white-50">3,143 Sales</p>
            <small class="text-success">✔ Available - 120 Stocks Remaining</small>
          </div>
        </div>
      </div>

      <!-- Item 3 -->
      <div class="carousel-item">
        <div class="d-flex align-items-center p-3 border rounded"
             style="background: rgba(88, 18, 106,0.2); backdrop-filter: blur(12px); transition: transform 0.3s, box-shadow 0.3s;">
          <img src="images/headphones.png" 
               class="rounded me-3" 
               width="140" height="100" 
               style="object-fit: contain;" 
               alt="Headphones">
          <div class="flex-grow-1">
            <h6 class="mb-1" style="color:#F6B2E1;">Sony WH-1000XM5 Headphones</h6>
            <p class="mb-0 text-white-50">5,678 Sales</p>
            <small class="text-success">✔ Available - 200 Stocks Remaining</small>
          </div>
        </div>
      </div>

    </div>
    
    <!-- Carousel Controls -->
    <button class="carousel-control-prev" type="button" data-bs-target="#topSellingCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" style="filter: drop-shadow(0 0 5px #F6B2E1);"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#topSellingCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" style="filter: drop-shadow(0 0 5px #F6B2E1);"></span>
    </button>
  </div>
</div>

 <!-- 📌 Activity Timeline + To-Do List -->
    <div class="row mt-5">
      <!-- Activity Timeline -->
      <div class="col-md-6">
        <div class="card p-3">
          <h4 class="fw-bold mb-3">📌 Activity Timeline</h4>
          <ul class="list-group">
            <li class="list-group-item">🛒 New order received </li>
            <li class="list-group-item">📦 Product “Nike Sportswear” shipped </li>
            <li class="list-group-item">👤 New user registered </li>
            <li class="list-group-item">⚠ Report received for product #5435DF </li>
          </ul>
        </div>
      </div>

     <div class="card p-4" style="background:#fff; border-radius:15px; box-shadow:0 8px 20px rgba(0,0,0,0.1); width:320px;">
  <h5 class="fw-bold mb-3">✅ To-Do List</h5>
  
  <ul class="todo-list">
    <li>
      <input type="checkbox" id="task1" checked>
      <label for="task1">Update product stock</label>
    </li>
    <li>
      <input type="checkbox" id="task2" checked>
      <label for="task2">Respond to 3 customer queries</label>
    </li>
    <li>
      <input type="checkbox" id="task3">
      <label for="task3">Review reported items</label>
    </li>
    <li>
      <input type="checkbox" id="task4">
      <label for="task4">Prepare discount offers</label>
    </li>
  </ul>
</div>
     
    
    
    <!-- Footer -->
    <footer>
      <p>&copy; Seller 2025. All Rights Reserved.</p>
    </footer>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script> 
    function toggleSidebar() {
      document.getElementById("sidebar").classList.toggle("collapsed");
      document.getElementById("content").classList.toggle("expanded");
    }
  </script> 
</body>