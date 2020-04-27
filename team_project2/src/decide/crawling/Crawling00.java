package decide.crawling;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;

import decide.model.dao.CrawlingDAO;
import decide.model.vo.CrawlingVo;

// url을받아 해당 페이지 크롤링하여 foodInfo DB에 데이터를 저장한다.

public class Crawling00 {
	
	
	private By mySelector;
	private ChromeDriver driver;
	private CrawlingVo vo;
	@Autowired
	private CrawlingDAO crawlingDAO;

	public void crawling(String url) {
		
		System.out.println(url);
		// WebDriver 경로 설정
        System.setProperty("webdriver.chrome.driver","C:\\Users\\pc\\Downloads\\chromedriver.exe");
        
        // WebDriver 옵션 설정
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");            //화면 안보이게 실행
        options.addArguments("--disable-popup-blocking");    // 팝업 무시
        options.addArguments("--disable-default-apps");     // 기본앱 사용안함
        
        // WebDriver 객체 생성
        driver = new ChromeDriver( options );
		
        // 웹페이지 요청
        driver.get(url);
        driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
        
        vo = new CrawlingVo();
        //dao = new CrawlingDAO();
        
        String name = driver.findElementByXPath("//*[@id=\"mArticle\"]/div[1]/div[1]/div[2]/div/h2").getText();
        String address = driver.findElementByXPath("//*[@id=\"mArticle\"]/div[1]/div[2]/div[1]/div/span[1]").getText();
        String phone = null;
        try {
        	phone = driver.findElementByXPath("//*[@class=\"txt_contact\"]").getText();        	
        }catch(NoSuchElementException n) {
        	n.printStackTrace();
        }
        String img = null;
        
        
        String type = driver.findElementByXPath("//*[@class=\"txt_location\"]").getText();
        String score = driver.findElementByXPath("//*[@id=\"mArticle\"]/div[1]/div[1]/div[2]/div/div/a[1]/span[1]").getText();
 
        // 필요데이터 크롤링해서 vo에 셋
        vo.setName(name);
        vo.setAddress(address);
        if(phone != null) {
        	vo.setPhone(phone);        	
        }
        vo.setType(type);
        vo.setUrl(url);
        vo.setScore(score);
        
        
        // vo에 담긴 데이터들 DB에 저장
        try {
        	crawlingDAO.insertBasic(vo);        	
        }catch(Exception e) {
        	e.printStackTrace();
        }
        
        // 웹페이지에서 메뉴크롤링해서 저장
        // 메뉴는 메뉴나 가격이 있을수도 없을수도있기에 나누어놧음
        // trim사용하여 SQL에서 나눌수도 있긴하지만.. 일단은 나눠놓음
        getMenu(driver, url);
  
        // 이미지주소 크롤링저장
        try {
        	driver.manage().timeouts().implicitlyWait(2, TimeUnit.SECONDS);
        	driver.findElement(By.xpath("//*[@id='mArticle']/div[1]/div[1]/div[1]/a/span[2]")).click();
        	driver.manage().timeouts().implicitlyWait(2, TimeUnit.SECONDS);
        	String fileName = driver.findElementByXPath("//*[@class='view_image']/img").getAttribute("src");
        	vo.setImg(fileName);
        	crawlingDAO.updateImg(vo);
        }catch(Exception e) {
        	e.printStackTrace();      	
        	try {
        		driver.findElement(By.xpath("//*[@id='mArticle']/div[1]/div[1]/div[1]/a/span")).click();    
        		String fileName = driver.findElementByXPath("//*[@class='view_image']/img").getAttribute("src");
        		vo.setImg(fileName);
        		crawlingDAO.updateImg(vo);
        	}catch(Exception t) {
        		t.printStackTrace();
        	}
        }
        
        // 탭 종료
        driver.close();
   
        // 8초 후에 WebDriver 종료
        try {
            Thread.sleep(8000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            // WebDriver 종료
            driver.quit();
        }
    }
	
	
	
	public void getMenu(ChromeDriver driver, String url) {
		// 메뉴가없거나, 더보기를 누를필요가 없을수도있으므로 예외처리
		
		vo = new CrawlingVo();
		
        try {
        	// 메뉴목록이 더보기를눌러야 전체목록이 나오는지 확인
        	mySelector = By.xpath("//*[@class=\'link_more\']");        	
        	for(int i = 0; i < 2; i++) {
        		WebElement a = driver.findElement(mySelector);
        		if(!a.getAttribute("class").equals("link_more")) break;
        		driver.findElement(mySelector).click();
        		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        	}
        	// 웹페이지에서 메뉴 가져오기
	        mySelector = By.xpath("//*[@class=\'list_menu\']/li/div/span");
	        List<WebElement> menu_list = driver.findElements(mySelector);
	        String menuList = "";
	        String priceList = "";
	        vo.setUrl(url);
	        
			if( menu_list != null ) {
				for(int i = 0; i < menu_list.size(); i++) {
					if(i == menu_list.size()-1) {
						menuList += menu_list.get(i).getText();
					}else {
						menuList += menu_list.get(i).getText()+",";						
					}
				}
				vo.setMenu(menuList);
				try {
					crawlingDAO.updateMenu(vo);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
	        
	        // 웹페이지에서 메뉴 가격 가져오기
			mySelector = By.xpath("//*[@class=\'list_menu\']/li/div/em[2]");
			List<WebElement> menu_price = driver.findElements(mySelector);
			
			if( menu_price != null ) {				
				for(int i = 0; i < menu_price.size(); i++) {
					if(i == menu_price.size()-1) {
						priceList += menu_price.get(i).getText();
					}else {
						priceList += menu_price.get(i).getText()+"원";						
					}
				}
				vo.setPrice(priceList);
				try {
					crawlingDAO.updatePrice(vo);					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}	
        }catch(NoSuchElementException n) {
        	n.printStackTrace();
        }finally {
        	
        }
		
	}
}
