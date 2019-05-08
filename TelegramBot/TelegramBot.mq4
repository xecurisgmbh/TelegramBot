//+------------------------------------------------------------------+
//|                                                  TelegramBot.mq4 |
//|                                                          XECURIS |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "XECURIS"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//--- input parameters
input string   accessToken;

int BarsCount = 0;

#import "TelegramBot.dll"
   void SendMessage(string msg);
   void Init(string token);
#import
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   Init(accessToken);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
  if (Bars>BarsCount)
  {
    double SlowMA = iMA(NULL, 0,20, 0, MODE_SMA, PRICE_CLOSE, 0);
    double LastSlowMA = iMA(NULL, 0,20, 0, MODE_SMA, PRICE_CLOSE, 1);
    double FastMA = iMA(NULL, 0,10, 0, MODE_SMA, PRICE_CLOSE, 0);
    double LastFastMA = iMA(NULL, 0,10, 0, MODE_SMA, PRICE_CLOSE, 1);
        
    if(LastFastMA < LastSlowMA && FastMA > SlowMA)
      SendMessage("Buy");
    if(LastFastMA > LastSlowMA && FastMA < SlowMA)
      SendMessage("Sell");
        
    BarsCount = Bars;
  }
}
//+------------------------------------------------------------------+