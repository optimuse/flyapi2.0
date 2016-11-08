<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<jsp:include page="static.jsp"></jsp:include>
<title>我创建的项目</title>
    <!-- Custom styling plus plugins -->
    <link href="<%=request.getContextPath()%>/static/ace/production/css/custom1.css" rel="stylesheet">
</head>
 <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>flyapi接口管理</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                <img src="<%=request.getContextPath()%>${sessionScope.user.avatarUrl}" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2>flyhero</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />
            <hr>


			<jsp:include page="base/sidebar.jsp"></jsp:include>

          </div>
        </div>

		<jsp:include page="base/top.jsp"></jsp:include>
        <!-- page content -->
        <div class="right_col" role="main">
                  <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Projects <small>Listing design</small></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                              <button class="btn btn-default" type="button">Go!</button>
                          </span>
                  </div>
                </div>
              </div>
            </div>
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Projects</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <p>Simple table with project listing with progress and editing options</p>


					<table class="table table-striped" id="cusTable"  
					       data-pagination="true"  
					       data-show-refresh="true"  
					       data-show-toggle="true"  
					       data-showColumns="true">  
					</table>  




                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
		<jsp:include page="base/footer.jsp"></jsp:include>
        <!-- /footer content -->
      </div>
    </div>

<script type="text/javascript">            
      function initTable() {  
    	  var id = ${sessionScope.user.userId};
        //先销毁表格  
        $('#cusTable').bootstrapTable('destroy');  
        //初始化表格,动态从服务器加载数据  
        $("#cusTable").bootstrapTable({  
            columns: [{
                field: 'project.projectId',
                title: '项目编号'
            },{
                field: 'project.proVersion',
                title: '版本号'
            },{
                field: 'project.createTime',
                title: '创建时间',
                formatter:function(value,row,index){  
                	/*	var date2 = new Date(row.project.createTime); 
                  return date2.toLocaleString();   */
                	 return getMyDate(row.project.createTime); 
             	} 
            },{
                field: 'project.proDes',
                title: '项目描述'
            },{
                field: 'project.targetCount',
                title: '已完成',
                formatter:function(value,row,index){  
		             var a=row.project.doneCount/row.project.targetCount*100;
		             var b='<div class="progress progress-striped active">'
		            	   +' <div class="progress-bar progress-bar-success" role="progressbar"'
		            	         +'aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"'
		            	         +'style="width: '
		            	         +a
		            	         +'%;">'
		            	    +'</div>'
		            	    +'<small>已完成'
		            	    +a
		            	    +'%</small>'
		            	+'</div>';
                 	 return b;  
             	} 
            },{
                title: '操作',
                field: 'id',
                align: 'center',
                width: 200,
                formatter:function(value,row,index){  
                     var f='<a href="../forward/project_detail.html?projectId='+row.project.projectId+'&upId='+row.upId+'" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> 查看 </a>'; 
                     var g='<a href="#" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> 编辑 </a>'; 
                     var h='<a href="#" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> 删除 </a>';
                  return f+g+h;  
              	} 
            } ],
            method: "get",  //使用get请求到服务器获取数据  
            url: "../project/findUserCreate.do", //获取数据的Servlet地址  
            striped: true,  //表格显示条纹  
            pagination: true, //启动分页  
            pageSize: 1,  //每页显示的记录数  
            pageNumber:1, //当前第几页  
            pageList: [5, 10, 15, 20, 25],  //记录数可选列表  
            search: true,  //是否启用查询  
            showColumns: true,  //显示下拉框勾选要显示的列  
            showRefresh: true,  //显示刷新按钮  
            sidePagination: "server", //表示服务端请求  
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder  
            //设置为limit可以获取limit, offset, search, sort, order  
            queryParamsType : "undefined",   
            queryParams: function queryParams(params) {   //设置查询参数  
              var param = {    
                  pageNumber: params.pageNumber,    
                  pageSize: params.pageSize,
                  userId:id
              };    
              return param;                   
            },  
            onLoadSuccess: function(){  //加载成功时执行  
             
            },  
            onLoadError: function(){  //加载失败时执行  
              
            }  
          });  
      }  
  
      $(document).ready(function () {          
          //调用函数，初始化表格  
          initTable();  
  
          //当点击查询按钮的时候执行  
          $("#search").bind("click", initTable);  
      });  
</script>  
	<!-- FastClick -->
	<script src="<%=request.getContextPath()%>/static/ace/vendors/fastclick/lib/fastclick.js"></script>

	<!-- Custom Theme Scripts -->
	<script src="<%=request.getContextPath()%>/static/ace/production/js/custom.js"></script>
	
  </body>
</html>