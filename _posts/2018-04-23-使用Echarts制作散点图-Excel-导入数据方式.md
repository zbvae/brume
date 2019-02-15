---
layout: post
title: 使用Echarts制作散点图(Excel 导入数据方式)
date: 2018-04-12 10:34:53
tags: [技术交流]

---
* 目录
{:toc #markdown-toc}

**摘要**：Echarts是一款有效的js制图工具很多时候，其主要优势在于网页浏览时，具有非常炫酷的效果，但是将其保存为静态图像也很美观。我们在写工作报告或写论文的时候，都需要制作基本的统计图表以直观展示结果数据，虽然Excel提供的图表制作工具能满足要求，但美观度欠佳，也许可以调整，但还是需要很大的工作量，今天给大家介绍一款非常实用的且有效的制图工具，相信，您亲自使用之后就知道它有多妙了！<!-- more -->

### Echarts简介

Echarts相当于一款JS插件，可以制作出绚丽多彩的图表，其支持制作的图表类型和可以使用的样式都非常丰富。

本文以Echarts制作散点图为例，向大家展示该工具的实用性。

### Echarts使用

Echarts的使用门槛非常简单，但使用条件必须符合规则，在[官网](http://echarts.baidu.com/)上下载开发包之后，自己准备一个项目主文件夹，在该文件夹新建一个js文件夹（名称自选），将开发包下的build文件夹下的dist文件夹拷贝到js文件夹下，便可以开始使用了。

Echarts的使用方式可以分为**AMD模块化导入**和**单文件导入**方式，本文介绍一种简单的单文件导入方式，首先准备好一个html文件，导入echarts.js文件即可。

当然你还需要准备一个div控件用于安放图表位置，也可以认为是要为Echarts实例化的Dom对象，这里JavaScript代码也放在body标签下。

```html
<!DOCTYPE html>
<head>    
    <meta charset="GBK"> 
    <title>Echarts of scatter</title>  
</head>

<body>
    <!--为Echarts准备一个大小为600*400的div-->
    <div id="main" style="width:600px;height:400px"></div> 
    <!--Echarts单文件导入-->     
    <script type="text/javascript" src="./js/dist/echarts.js"></script> 
</body>
```

至此，Echarts文件已完成导入，在使用之前，还需要进行路径配置：

```html
<!DOCTYPE html>
<head>    
    <meta charset="GBK"> 
    <title>Echarts of scatter</title>  
</head>

<body>
    <!--为Echarts准备一个大小为600*400的div-->
    <div id="main" style="width:600px;height:400px"></div> 
    
    <!--Echarts单文件导入-->     
    <script type="text/javascript" src="./js/dist/echarts.js"></script> 
    <script type="text/javascript">
        //配置路径
        require.config({
            paths:{         
                 echarts:'./js/dist'
            }
        }) 
    </script> 
</body>
```

路径配置好后，可以进行使用，首先需要指定要制作的图表，进行模块导入，可以根据需要导入多个图表模块：

```javascript

<script type="text/javascript">    
    //配置路径 
    require.config({
      	paths:{
        	echarts:'./js/dist'
      	} 
    }) 

    //使用     
    require(
        [     
            'echarts',
            'echarts/chart/scatter' 
        ] 
    )
</script>

```

基于原先的div创建echarts，并使用，主要是图表option的配置:

```javascript
<script type="text/javascript">
  //配置路径
  require.config({
   	paths:{
    	echarts:'./js/dist'
   	}
  });

  //使用
  require(
   	[
    	'echarts',
    	'echarts/chart/scatter'
   	],
  
   function(ec){
    //基于准备好的DOM，初始化echarts图表
    var myChart = ec.init(document.getElementById('main'),'shine'); //这里的shine可以改成其他样式，可以参照官网实例的样式表
    var option = {
     	title:{
      		//可以指定图表标题
     	},
     	renderAsImage : true,
    	//symbolList : ["emptyCircle"],
     	tooltip:{//提示框的显示，主要具有web效果
      		show:true,
      		trigger: 'axis',
      		showDelay : 0,
      		axisPointer:{
       			show: true,
      	 		type : 'cross',
       			lineStyle: {
        			type : 'dashed',
        			width : 1
       			}
      		}
     	},

     	xAxis:[
      		{
       			name : 'WrG',
       			type : 'value',
       			scale:true,
      		}
     	],
     	yAxis:[
      		{
       			name: 'Cu',
       			type : 'value',
       			scale:true,
      		}
     	],

     	series:[
      		{
       			"name":"CuOre",
       			"type":"scatter",
       			"data":xyData,//注意这里的xyData就是关键的散点图显示数据，是一个二维数组，即数组内部每一个元素都是xy值对
       			"markPoint" : {
        			//标记点 
        			data : [
        				{type:'max'},
        				{type:'min'} 
        			]
       			},
       			"markLine" : {
            		//标记线自己定制 
        		}
      		}
     	]
    };
    //为ECharts对象加载数据
    myChart.setOption(option);
   	}
  );
 </script>
```

现在图表的各项已经配置完毕，关键就是xyData数据的充填，当然用户可以自行指定为：[[1,2],[2,2],[3,4],[4,5]],数据少的时候我们可以直接充填，但是数据条目一旦很多，人工输入就很难完成了，因此这里介绍一种从Excel导入数据,再利用js重新组装来进行xyData的充填。代码如下：

```javascript
<!-- 以下是设置从Excel中加载数据-->
 <script type="text/javascript">  
    function importXLS(field){   
       	var fullpath = window.document.location.pathname;
       	var pos1 = fullpath.indexOf("/");
       	var fileName1 = fullpath.substring(pos1+1);
       	var pos2 = fileName1.lastIndexOf("/");

       	var fileName = fileName1.substring(0,pos2) + "/scatter_data.xls";// xls文件的路径  
       	objCon = new ActiveXObject("ADODB.Connection"); 
       	objCon.Provider = "Microsoft.Jet.OLEDB.4.0";  
       	objCon.ConnectionString = "Data Source=" + fileName + ";Extended Properties=Excel 8.0;";  
       	objCon.CursorLocation = 1;  
       	objCon.Open;  
       	var strQuery;  

    	//Get the SheetName  
       	var strSheetName = "Sheet1$"; //要导入的sheet的名字  

   		var rsTemp =   new ActiveXObject("ADODB.Recordset");  
   		rsTemp = objCon.OpenSchema(20); 
   		if(!rsTemp.EOF)strSheetName = rsTemp.Fields("Table_Name").Value;  
   		rsTemp = null;  

   		rsExcel =   new ActiveXObject("ADODB.Recordset");  
   		strQuery = "SELECT * FROM [" + strSheetName + "]";  
   		rsExcel.ActiveConnection = objCon;  
   		rsExcel.Open(strQuery);  

   		var res = [];  
   		var temp;  

   		while(!rsExcel.EOF){  
    		temp = rsExcel.Fields(field).value;
    		res.push(temp);
    		rsExcel.MoveNext;
   		}   

   		// Close the connection and dispose the file  
   		objCon.Close;  
   		objCon =null;  
   		rsExcel = null;  
   		return res;   
 	}  
 </script>
```

导入的Excel数据是读取某个字段的一维数组数据，我们需要导入x,y两个字段的数据，并组装成xyData二维数组格式：

```javascript
<script type="text/javascript">
	function(ec){
	    var xData = importXLS(1);
	    var yData = importXLS(2);
	    var xyData = [];

	    var i;
	    //转化为散点图需要的二维数组系列
	    for(i=0;i<xData.length;i++){
	     xyData.push(new Array(xData[i],yData[i]));
	    }

	    //基于准备好的DOM，初始化echarts图表
	    var myChart = ec.init(document.getElementById('main'),'shine');
	    ... //接着上面的使用Echarts的代码
	}
</script>

```

这样便实现了从Excel中导入数据，重新组装，充填为散点图所需要的二维数组格式。

给一个本程序生成的静态图片如下：

<center>![散点图，样式为infographic](/images/scatter1.png)![散点图，样式为shine](/images/scatter2.png)</center>