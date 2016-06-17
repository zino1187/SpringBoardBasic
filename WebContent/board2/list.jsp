<%@page import="com.study.board.model.Board"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<Board> list=(List)request.getAttribute("list");	

	//웹을 통해 전송되는 데이터는 숫자형이 있을 수 없다... (스트림을 통해 전송하지 않는 한...)
	int currentPage=1; //현재 페이지
	if(request.getParameter("currentPage") !=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int totalRecord=list.size(); //총 레코드 수 
	int pageSize=10; //한 페이지당 보여질 레코드 수
	int totalPage=(int)Math.ceil((float)totalRecord/pageSize);
	
	int blockSize=10; //한 블럭당 보여질 페이지 수
	
	//out.print("총 페이지 수는 "+totalPage+"<br>");
	out.print("당신은 "+currentPage+" 페이지를 보고있어요!!<br>");
	int firstPage=currentPage - (currentPage-1)%blockSize;
	int lastPage=firstPage+(blockSize-1);
	
	int curPos=(currentPage-1)*pageSize;//페이지당 list의 시작 index
	int num=totalRecord - curPos;//페이지당 시작 번호
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
#box{border:1px solid #CCCCCC}
#title{font-size:9pt;font-weight:bold;color:#7F7F7F;돋움}
#category{font-size:9pt;color:#7F7F7F;돋움}
#keyword{
	width:80px;
	height:17px;
	font-size:9pt;
	border-left:1px solid #333333;
	border-top:1px solid #333333;
	border-right:1px solid #333333;
	border-bottom:1px solid #333333;
	color:#7F7F7F;돋움
}
#paging{font-size:9pt;color:#7F7F7F;돋움}
#list td{font-size:9pt;}
#copyright{font-size:9pt;}
a{text-decoration:none}
img{border:0px}
</style>
</head>
<body>
<table id="box" align="center" width="603" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="5"><img src="/images/ceil.gif" width="603" height="25"></td>
  </tr>
  <tr>
    <td height="2" colspan="5" bgcolor="#6395FA"><img src="/images/line_01.gif"></td>
  </tr>
  <tr id="title" align="center">
    <td width="50" height="20">번호</td>
    <td width="303" height="20">제목</td>
    <td width="100" height="20">글쓴이</td>
    <td width="100" height="20">날짜</td>
    <td width="50" height="20">조회수</td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#CCCCCC"></td>
  </tr>
	<tr>	
		<td colspan="5" id="list">
		  <table width="100%" border="0" cellpadding="0" cellspacing="0">
		    <%for(int i=1;i<=pageSize;i++){ %>
		    <%if(num<1)break; //게시물이 더 이상 없다면 브레이크!!%>
		    <% Board board=list.get(curPos++); %>
		    <tr align="center" height="20px" onMouseOver="this.style.background='#FFFF99'" onMouseOut="this.style.background=''">
			  <td width="50"><%=num-- %></td>
			  <td width="303"><a href="/board/detail.do?board_id=<%=board.getBoard_id()%>"><%=board.getTitle() %></a></td>
			  <td width="100"><%=board.getWriter() %></td>
			  <td width="100"><%=board.getRegdate() %></td>
			  <td width="50"><%=board.getHit() %></td>
		    </tr>
			<tr>
				<td height="1" colspan="5" background="/images/line_dot.gif"></td>
			</tr>
			<%} %>
		  </table>		</td>
	</tr>
  <tr>
    <td id="paging" height="20" colspan="5" align="center">
    ◀
   	<%for(int i=firstPage;i<=lastPage;i++){ %>
    <a href="/board2/list.jsp?currentPage=<%=i%>">[<%=i%>]</a>
    <%} %>
    <a href="/board2/list.jsp?currentPage=<%=lastPage+1%>">▶</a>
    </td>
  </tr>
  <tr>
    <td height="20" colspan="5" align="right" style="padding-right:2px;">
	<table width="160" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="70">
          <select name="select" id="category">
            <option>제목</option>
            <option>내용</option>
            <option>글쓴이</option>
          </select>        </td>
        <td width="80">
          <input name="textfield" id="keyword" type="text" size="15">        </td>
        <td><img src="/images/search_btn.gif" width="32" height="17"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="30" colspan="5" align="right" style="padding-right:2px;"><a href="write.jsp"><img src="/images/write_btin.gif" width="61" height="20" border="0"></a></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#CCCCCC"></td>
  </tr>
  <tr>
    <td height="20" colspan="5" align="center" id="copyright">Copyright zino All Rights Reserved </td>
  </tr>
</table>
</body>
</html>
