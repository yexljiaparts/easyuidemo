package com.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * http://blog.csdn.net/ab7253957/article/details/76076600
 * Created by Administrator on 2017/11/1.
 */
public class PoiUtil {

    /**
     * Excel2003和Excel2007+创建方式不同
     * Excel2003使用HSSFWorkbook 后缀xls
     * Excel2007+使用XSSFWorkbook 后缀xlsx
     * 此方法可保证动态创建Workbook
     *
     * @param is
     * @return
     */
    public static Workbook createWorkbook(InputStream is) throws IOException, InvalidFormatException {
        return WorkbookFactory.create(is);
    }

    /**
     *导入数据获取数据列表
     * @param wb
     * @return
     */
    public static List<List<Object>> getDataList(Workbook wb) {
        List<List<Object>> rowList = new ArrayList<List<Object>>();
        for (int sheetNum = 0; sheetNum < wb.getNumberOfSheets(); sheetNum++) {
            Sheet sheet = wb.getSheetAt(sheetNum);
            for (int i = sheet.getFirstRowNum(); i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (null == row)
                    continue;
                List<Object> cellList = new ArrayList<Object>();
                for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++) {
                    Cell cell = row.getCell(j);
                    cellList.add(getCellValue(cell));
                }
                rowList.add(cellList);
            }
        }
        return rowList;
    }

    private static String getCellValue(Cell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
                // 如果当前Cell的Type为NUMERIC
                case HSSFCell.CELL_TYPE_NUMERIC: {
                    short format = cell.getCellStyle().getDataFormat();
                    if (format == 14 || format == 31 || format == 57 || format == 58) {   //excel中的时间格式
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        double value = cell.getNumericCellValue();
                        Date date = DateUtil.getJavaDate(value);
                        cellvalue = sdf.format(date);
                    }
                    // 判断当前的cell是否为Date
                    else if (HSSFDateUtil.isCellDateFormatted(cell)) {  //先注释日期类型的转换，在实际测试中发现HSSFDateUtil.isCellDateFormatted(cell)只识别2014/02/02这种格式。
                        // 如果是Date类型则，取得该Cell的Date值           // 对2014-02-02格式识别不出是日期格式
                        Date date = cell.getDateCellValue();
                        DateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
                        cellvalue = formater.format(date);
                    } else { // 如果是纯数字
                        // 取得当前Cell的数值
                        cellvalue = NumberToTextConverter.toText(cell.getNumericCellValue());

                    }
                    break;
                }
                // 如果当前Cell的Type为STRIN
                case HSSFCell.CELL_TYPE_STRING:
                    // 取得当前的Cell字符串
                    cellvalue = cell.getStringCellValue().replaceAll("'", "''");
                    break;
                case HSSFCell.CELL_TYPE_BLANK:
                    cellvalue = null;
                    break;
                // 默认的Cell值
                default: {
                    cellvalue = " ";
                }
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;
    }


    /**
     * 此方法生成表头并写入表头名称
     *
     * @param nodes 节点
     * @param sheet 工作簿
     * @param style 单元格样式
     * @return 数据加载开始行
     */
    public static int generateHeader(List<HeaderNode> nodes, Sheet sheet, CellStyle style) {
        Map<Integer, Row> hssfRowMap = new HashMap<Integer, Row>();
        for(int i=0;i<6;i++){
            Row row= sheet.createRow(i);
            hssfRowMap.put(i, row);
        }
        int dataStartRow = 0;
        for (HeaderNode node : nodes) {
            dataStartRow = dataStartRow >= node.getLastRow() ? dataStartRow : node.getLastRow();
for(int j=node.getFirstRow();j<=node.getLastRow();j++){
                for(int i=node.getFirstCol();i<=node.getLastCol();i++){
                    Cell cell2 = (hssfRowMap.get(j)).createCell(i);
                    cell2.setCellValue(node.getName());
                    cell2.setCellStyle(style);
                    sheet.setColumnWidth(i,node.getName().length()*512);
                }
}
            CellRangeAddress cra = new CellRangeAddress(node.getFirstRow(), node.getLastRow(),
                    node.getFirstCol(), node.getLastCol());
            sheet.addMergedRegion(cra);

        }
        return dataStartRow+1;
    }


    public static class HeaderNode {
        private String name;
        private int firstRow;
        private int lastRow;
        private int firstCol;
        private int lastCol;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getFirstRow() {
            return firstRow;
        }

        public void setFirstRow(int firstRow) {
            this.firstRow = firstRow;
        }

        public int getLastRow() {
            return lastRow;
        }

        public void setLastRow(int lastRow) {
            this.lastRow = lastRow;
        }

        public int getFirstCol() {
            return firstCol;
        }

        public void setFirstCol(int firstCol) {
            this.firstCol = firstCol;
        }

        public int getLastCol() {
            return lastCol;
        }

        public void setLastCol(int lastCol) {
            this.lastCol = lastCol;
        }
    }

    private static class RowKey {
        private int firstRow;
        private int lastRow;
        private int firstCol;
        private int lastCol;
        public int getFirstRow() {
            return firstRow;
        }

        public void setFirstRow(int firstRow) {
            this.firstRow = firstRow;
        }

        public int getLastRow() {
            return lastRow;
        }

        public int getFirstCol() {
            return firstCol;
        }

        public void setFirstCol(int firstCol) {
            this.firstCol = firstCol;
        }

        public int getLastCol() {
            return lastCol;
        }

        public void setLastCol(int lastCol) {
            this.lastCol = lastCol;
        }

        public void setLastRow(int lastRow) {
            this.lastRow = lastRow;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof RowKey)) return false;
            RowKey key = (RowKey) o;
            return firstRow == key.firstRow &&
                    lastRow == key.lastRow;
        }

        @Override
        public int hashCode() {
            return 0;
      /*      return Objects.hash(firstRow, lastRow);*/
        }
    }


    public static void main(String[] args) {
        // 第一步，创建一个webbook，对应一个Excel文件
        Workbook workbook = new XSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        Sheet sheet = workbook.createSheet("测试");
        // 第四步，创建单元格，并设置值表头 设置表头居中
        CellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER); // 水平居中格式
        style.setVerticalAlignment(VerticalAlignment.CENTER); //垂直居中
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        List<HeaderNode> nodes = new ArrayList<HeaderNode>();
        HeaderNode headerNode1 = new HeaderNode();
        headerNode1.setName("test1");
        headerNode1.setFirstRow(0);
        headerNode1.setLastRow(1);
        headerNode1.setFirstCol(0);
        headerNode1.setLastCol(5);
        nodes.add(headerNode1);
        HeaderNode headerNode2 = new HeaderNode();
        headerNode2.setName("test2");
        headerNode2.setFirstRow(2);
        headerNode2.setLastRow(3);
        headerNode2.setFirstCol(0);
        headerNode2.setLastCol(4);
        nodes.add(headerNode2);
        HeaderNode headerNode3 = new HeaderNode();
        headerNode3.setName("test3");
        headerNode3.setFirstRow(2);
        headerNode3.setLastRow(3);
        headerNode3.setFirstCol(5);
        headerNode3.setLastCol(5);
        nodes.add(headerNode3);
        HeaderNode headerNode34 = new HeaderNode();
        headerNode34.setName("test4");
        headerNode34.setFirstRow(4);
        headerNode34.setLastRow(5);
        headerNode34.setFirstCol(0);
        headerNode34.setLastCol(5);
        nodes.add(headerNode34);
        HeaderNode headerNode5= new HeaderNode();
        headerNode5.setName("test5");
        headerNode5.setFirstRow(0);
        headerNode5.setLastRow(5);
        headerNode5.setFirstCol(6);
        headerNode5.setLastCol(6);
        nodes.add(headerNode5);
        generateHeader(nodes, sheet, style);
        try {
            FileOutputStream output = new FileOutputStream("e:\\workbook.xls");
            workbook.write(output);
            output.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}



/*    List<PoiUtil.HeaderNode> nodes = new ArrayList<>();
 for (RpStyleItem item : styleItems){
         PoiUtil.HeaderNode headerNode = new PoiUtil.HeaderNode();
         headerNode.setFirstRow(item.getRow() - 1);
         headerNode.setLastRow(headerNode.getFirstRow()+item.getSizeY() - 1);
         headerNode.setFirstCol(item.getCol() - 1);
         headerNode.setLastCol(headerNode.getFirstCol() + item.getSizeX() - 1);
         headerNode.setName(item.getName());
         nodes.add(headerNode);
         }
         // 第一步，创建一个webbook，对应一个Excel文件
         // XSSFWorkbook针对于excel2007+
         // HSSFWorkbook针对于Excel2003(数据超过65536会报错)
         Workbook workbook = new XSSFWorkbook();
         // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
         Sheet sheet = workbook.createSheet(template.getName());
         // 第三步，创建单元格样式
         CellStyle style = workbook.createCellStyle();
         style.setAlignment(HorizontalAlignment.CENTER); // 水平居中格式
         style.setVerticalAlignment(VerticalAlignment.CENTER); //垂直居中
         int rowNum = PoiUtil.generateHeader(nodes,sheet,style);
         String sql = template.getReportSql().replace("\n", " ");
         String reportDate = com.jrq.components.date.DateUtil.dateFormat(new Date(), "yyyyMMdd");
         //测试数据 String reportDate = "20170711";
         List<Map<String, Object>> datas = reportService.listReportData(reportDate, sql);
        for (Map<String, Object> map : datas){
        Collection<Object> values = map.values();
        int index = 0; //cell单元格索引
        Row row = sheet.createRow(rowNum++);
        for (Object obj : values){
        row.createCell(index++).setCellValue(obj.toString());
        }
        }
        * 直接将将文件保存在本地，供测试样式使用
        try {
        OutputStream output=new FileOutputStream("e:\\workbook.xls");
        workbook.write(output);
        output.flush();
        output.close();
        } catch (IOException e) {
        e.printStackTrace();
        }*//*
        String downFileName = new String(template.getType().getName()+reportDate+".xls");
        try {
        //若不进行编码在IE下会乱码
        downFileName = URLEncoder.encode(downFileName, "UTF-8");
        } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
        }
        try {
        // 清空response
        response.reset();
        response.setContentType("application/msexcel");//设置生成的文件类型
        response.setCharacterEncoding("UTF-8");//设置文件头编码方式和文件名
        response.setHeader("Content-Disposition", "attachment; filename=" + downFileName);
        OutputStream os=response.getOutputStream();
        workbook.write(os);
        os.flush();
        os.close();
        } catch (IOException e) {
        LOG.error("文件流操作异常");
        jr.setRet("文件流操作异常");
        return jr;
        }
        jr.setSuc(JsonResponse.SUCCESS);
        return jr;  */
