# AlphaCampFinalAssessment  
##Question1：  
演算法思路：  
用for迴圈將1~100當中不能被2整除的數字相加，完成  
##Questio2：
解題思路：  
1.在Storyboard上面的view生成兩個Label物件，兩個Label分別設定backgroundColor為橘跟綠，設定兩個Label寬度相等。  
2.在最外層View的leading方向邊框、橘色Label、綠色Label、trailling方向邊框中間插入三個View，彼此相距為0。  
3.三個View的backgroundColor設為透明，並且寬度相等設定為5。  
4.完成  
##Questio3：  
解題思路：  
1.用URLSession.shared.dataTask發送GET的Request指令，在completionHandler解析回傳回來的data，  
解析JSON的方法使用SwiftyJSON套件，把origin的值用NSLog的方法印出來，以上動作包進getOringin()裡面，  
在按下sendGet(_ sender: UIButton)事件裡頭觸發。  
2.在發送POST時，用Data()和DateFormatter()生成時間的字串，並用JSON格式把時間字串包進request的Body後，  
用URLSession.shared.uploadTask發送POST的Request指令，收到回傳的資料後，  
用Date()跟timeIntervalSince()去計算現在時間跟發送POST時間的差，  
以上動作包進postRequest()裡面，在按下sendPost(_ sender: UIButton)事件裡頭觸發  
3.完成  
##Questio4：
解題思路：  
1.生成CollectionViewController，其中利用UICollectionViewDelegateFlowLayout的方法，  
來把Cell長跟寬調整為2*3格佔滿畫面，Cell之間的間距調整為0。  
2.顯示一個AlerView：  
用UIAlertController生成，完成  
3.顯示藍色,點擊後變成紅色,再次點擊又變成藍色：  
每次點擊Cell時檢查Cell的backgroundColor，不是紅色就改成紅色，否則變更成藍色。  
4.透過CoreMotion顯示使用者現在的步數，並且即時更新：  
5.開啟APP在IOS設定的頁面：  
在storyboard設立另一個ViewController，並和CollectionViewController建立segue，  
用performSegue方法轉場到該ViewController。
6.打開GoogleMap或是Web導航至AlphaCamp：  
設定好打開網頁版跟打開Ios應用程式的GoogleMAP並導航到AlphaCamp的連結，  
先判定系統是否Ios10.0以上，  
10.0以上：UIApplication.shared.open方法判別GoogleMap應用程式連結是否可用，  
如不可用就在completionHandler中再呼叫一次UIApplication.shared.open去打開網頁版GoogleMap連結  
Ios9以下：UIApplication.shared.canOpenURL判斷打開應用程式的URl是否可用，  
如可用就用UIApplication.shared.openURL打開，  
如不可用就用UIApplication.shared.openURL打開網頁版GooegleMap連結。完成
7.開啟信箱並將標題寫上\"測試信件：  
遵從MFMailComposeViewControllerDelegate,UINavigationControllerDelegate，  
並設定CollectionViewController為delegate，生成MFMailComposeViewController()物件，  
並設定.setSubject、.setToRecipients、.setMessageBody，然後present出來。  
並設定按下取消後的要dismiss畫面上的MFMailComposeViewController，完成。
##Questio5：  







