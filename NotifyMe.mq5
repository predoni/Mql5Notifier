//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
string versionECN         = "1.08";
int    handleRSI          = 0;
int    handleStochastic   = 0;
bool   notifedRSI         = false;
bool   notifedStochastic  = false;
bool   notifiedSpread_100 = false;
bool   notifiedSpread_110 = false;
bool   notifiedSpread_120 = false;
bool   notifiedSpread_130 = false;
bool   notifiedSpread_140 = false;
bool   notifiedSpread_150 = false;
bool   notifiedSpread_175 = false;
bool   notifiedSpread_200 = false;
bool   notifiedSpread_225 = false;
bool   notifiedSpread_250 = false;
bool   notifiedSpread_275 = false;
bool   notifiedSpread_300 = false;
bool   notifiedSpread_325 = false;
bool   notifiedSpread_350 = false;
bool   notifiedSpread_375 = false;
bool   notifiedSpread_400 = false;
bool   notifiedSpread_425 = false;
bool   notifiedSpread_450 = false;
bool   notifiedSpread_475 = false;
bool   notifiedSpread_500 = false;
double iStochasticMainBuffer[];
double iStochasticSignalBuffer[];
double iRSIBuffer[];
datetime dtReset = 0;
MqlDateTime dateReset;
//+------------------------------------------------------------------+
int OnInit()
{
   if (!ChartSetSymbolPeriod(0, NULL, PERIOD_D1)) {
      Print("ERROR: ExecutSpread Unable to change the chart to D1. => ", GetLastError());
      return(INIT_FAILED);
   }
   
   dtReset = GetDateToday(dateReset);
   
   SendNotification(_Symbol + ": Notify versionECN: " + versionECN);
   Print(_Symbol + ": Notify versionECN: " + versionECN);
   
   ResetLastError();
   SetIndexBuffer(0,iRSIBuffer,INDICATOR_DATA);
   handleRSI = iRSI(_Symbol,PERIOD_CURRENT,7,PRICE_CLOSE); 
   if(handleRSI == INVALID_HANDLE) 
   {
      PrintFormat("Failed to create handle of the iRSI indicator for the symbol %s/%s, error code %d", 
                  _Symbol, 
                  EnumToString(PERIOD_CURRENT), 
                  GetLastError());
      return(INIT_FAILED); // In this case stop the programm!!!
   }
   
   ResetLastError();
   SetIndexBuffer(0,iStochasticMainBuffer,INDICATOR_DATA);
   SetIndexBuffer(0,iStochasticSignalBuffer,INDICATOR_DATA);
   handleStochastic = iStochastic(_Symbol, PERIOD_CURRENT, 5, 3, 3, MODE_SMA, STO_LOWHIGH); 
   if(handleStochastic == INVALID_HANDLE) 
   {
      PrintFormat("Failed to create handle of the iStochastic indicator for the symbol %s/%s, error code %d", 
                  _Symbol, 
                  EnumToString(PERIOD_CURRENT), 
                  GetLastError());
      return(INIT_FAILED); // In this case stop the programm!!!
   }
   
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   MqlDateTime timeCurrent;
   datetime dtTimeCurrent = TimeCurrent(timeCurrent);
   
   MqlTick currentTick;
   SymbolInfoTick(_Symbol, currentTick);
   
   NotifySpread(dtTimeCurrent, timeCurrent, currentTick);
   //ExecuteRSI(dtTimeCurrent, timeCurrent, currentTick);
   //ExecuteStochastic(dtTimeCurrent, timeCurrent, currentTick);
}
//+------------------------------------------------------------------+
void NotifySpread(datetime dtTimeCurrent, MqlDateTime &timeCurrent, MqlTick &currentTick)
{
   MqlRates rates[];
   int copiedMqlRates = CopyRates(_Symbol, PERIOD_CURRENT, 0, 1, rates);
   if (copiedMqlRates <= 0)
      Print("Error copying price data ", GetLastError());
   
   Reset();
   
   MqlRates ratesUltima = rates[0];
   double hlSpread = ratesUltima.high - ratesUltima.low;
   double pip100 = 1000 * _Point;
   double pip110 = 1100 * _Point;
   double pip120 = 1200 * _Point;
   double pip130 = 1300 * _Point;
   double pip140 = 1400 * _Point;
   double pip150 = 1500 * _Point;
   double pip175 = 1750 * _Point;
   double pip200 = 2000 * _Point;
   double pip225 = 2250 * _Point;
   double pip250 = 2500 * _Point;
   double pip275 = 2750 * _Point;
   double pip300 = 3000 * _Point;
   double pip325 = 3250 * _Point;
   double pip350 = 3500 * _Point;
   double pip375 = 3750 * _Point;
   double pip400 = 4000 * _Point;
   double pip425 = 4250 * _Point;
   double pip450 = 4500 * _Point;
   double pip475 = 4750 * _Point;
   double pip500 = 5000 * _Point;
   
   if (!notifiedSpread_100 && hlSpread >= pip100) {
      SendNotification(_Symbol + ": high - low >= 100 pip");
      notifiedSpread_100 = true;
      return;
   }
   
   if (!notifiedSpread_110 && hlSpread >= pip110) {
      SendNotification(_Symbol + ": high - low >= 110 pip");
      notifiedSpread_110 = true;
      return;
   }
   
   if (!notifiedSpread_120 && hlSpread >= pip120) {
      SendNotification(_Symbol + ": high - low >= 120 pip");
      notifiedSpread_120 = true;
      return;
   }
   
   if (!notifiedSpread_130 && hlSpread >= pip130) {
      SendNotification(_Symbol + ": high - low >= 130 pip");
      notifiedSpread_130 = true;
      return;
   }
   
   if (!notifiedSpread_140 && hlSpread >= pip140) {
      SendNotification(_Symbol + ": high - low >= 140 pip");
      notifiedSpread_140 = true;
      return;
   }
   
   if (!notifiedSpread_150 && hlSpread >= pip150) {
      SendNotification(_Symbol + ": high - low >= 150 pip");
      notifiedSpread_150 = true;
      return;
   }
   
   if (!notifiedSpread_175 && hlSpread >= pip175) {
      SendNotification(_Symbol + ": high - low >= 175 pip");
      notifiedSpread_175 = true;
      return;
   }
   
   if (!notifiedSpread_200 && hlSpread >= pip200) {
      SendNotification(_Symbol + ": high - low >= 200 pip");
      notifiedSpread_200 = true;
      return;
   }
   
   if (!notifiedSpread_225 && hlSpread >= pip225) {
      SendNotification(_Symbol + ": high - low >= 225 pip");
      notifiedSpread_225 = true;
      return;
   }
   
   if (!notifiedSpread_250 && hlSpread >= pip250) {
      SendNotification(_Symbol + ": high - low >= 250 pip");
      notifiedSpread_250 = true;
      return;
   }
   
   if (!notifiedSpread_275 && hlSpread >= pip275) {
      SendNotification(_Symbol + ": high - low >= 275 pip");
      notifiedSpread_275 = true;
      return;
   }
   
   if (!notifiedSpread_300 && hlSpread >= pip300) {
      SendNotification(_Symbol + ": high - low >= 300 pip");
      notifiedSpread_300 = true;
      return;
   }
   
   if (!notifiedSpread_325 && hlSpread >= pip325) {
      SendNotification(_Symbol + ": high - low >= 325 pip");
      notifiedSpread_325 = true;
      return;
   }
   
   if (!notifiedSpread_350 && hlSpread >= pip350) {
      SendNotification(_Symbol + ": high - low >= 350 pip");
      notifiedSpread_350 = true;
      return;
   }
   
   if (!notifiedSpread_375 && hlSpread >= pip375) {
      SendNotification(_Symbol + ": high - low >= 375 pip");
      notifiedSpread_375 = true;
      return;
   }
   
   if (!notifiedSpread_400 && hlSpread >= pip400) {
      SendNotification(_Symbol + ": high - low >= 400 pip");
      notifiedSpread_400 = true;
      return;
   }
   
   if (!notifiedSpread_425 && hlSpread >= pip425) {
      SendNotification(_Symbol + ": high - low >= 425 pip");
      notifiedSpread_425 = true;
      return;
   }
   
   if (!notifiedSpread_450 && hlSpread >= pip450) {
      SendNotification(_Symbol + ": high - low >= 450 pip");
      notifiedSpread_450 = true;
      return;
   }
   
   if (!notifiedSpread_475 && hlSpread >= pip475) {
      SendNotification(_Symbol + ": high - low >= 475 pip");
      notifiedSpread_475 = true;
      return;
   }
   
   if (!notifiedSpread_500 && hlSpread >= pip500) {
      SendNotification(_Symbol + ": high - low >= 500 pip");
      notifiedSpread_500 = true;
      return;
   }
}
//+------------------------------------------------------------------+
void ExecuteRSI(datetime dtTimeCurrent, MqlDateTime &timeCurrent, MqlTick &currentTick)
{
   ArrayFree(iRSIBuffer);
   CopyBuffer(handleRSI,0,0,1,iRSIBuffer);
   
   //PrintFormat("RSI current value = %s", DoubleToString(iRSIBuffer[0]));
   
   if (!notifedRSI && (iRSIBuffer[0] >= 90 || iRSIBuffer[0] <= 10))
   {
      SendNotification(_Symbol + " - RSI: " + DoubleToString(iRSIBuffer[0]));
      notifedRSI = true;
   }
   
   if (notifedRSI && 20 < iRSIBuffer[0] && iRSIBuffer[0] < 80)
      notifedRSI = false;
}
//+------------------------------------------------------------------+
void ExecuteStochastic(datetime dtTimeCurrent, MqlDateTime &timeCurrent, MqlTick &currentTick)
{
   //--- reset error code 
   ResetLastError(); 
   
   ArrayFree(iStochasticMainBuffer);
   ArrayFree(iStochasticSignalBuffer);
   
   if (CopyBuffer(handleStochastic,MAIN_LINE,0,1,iStochasticMainBuffer) < 0)
      PrintFormat("Failed to copy data from the iStochastic indicator, error code %d",GetLastError()); 
   
   if (CopyBuffer(handleStochastic,SIGNAL_LINE,0,1,iStochasticSignalBuffer) < 0)
      PrintFormat("Failed to copy data from the iStochastic indicator, error code %d",GetLastError()); 
   
   //PrintFormat("RSI current value = %s", DoubleToString(iRSIBuffer[0]));
   
   //if (!notifedStochastic && (iStochasticMainBuffer[0] >= 99 || iStochasticMainBuffer[0] <= 1))
   //{
   //   SendNotification(_Symbol + " - Stochastic: " + DoubleToString(iStochasticMainBuffer[0]));
   //   notifedStochastic = true;
   //}
   
   if (!notifedStochastic && (iStochasticSignalBuffer[0] >= 95 || iStochasticSignalBuffer[0] <= 5))
   {
      SendNotification(_Symbol + " - Stochastic: " + DoubleToString(iStochasticSignalBuffer[0]));
      notifedStochastic = true;
   }
   
   if (notifedStochastic && 15 < iStochasticMainBuffer[0] && iStochasticMainBuffer[0] < 85)
      notifedStochastic = false;
}
//+------------------------------------------------------------------+
datetime GetDateToday(MqlDateTime &dateCurrent)
{
   datetime dtCurrent = TimeCurrent(dateCurrent);
   dateCurrent.hour = 0;
   dateCurrent.min  = 0;
   dateCurrent.sec  = 0;
   
   return StructToTime(dateCurrent);
}
//+------------------------------------------------------------------+
datetime AddOneDay(datetime dt)
{
   return (dt + (60 /*sec*/ * 60 /*min*/ * 24 /*hours*/)); // Add one day.
}
//+------------------------------------------------------------------+
void Reset()
{
   MqlDateTime dtStruct;
   datetime dtCurrent = TimeCurrent();
   datetime dtTomorrow = AddOneDay(dtReset);
   
   if (dtCurrent > dtTomorrow)
   {
      // Reset.
      notifiedSpread_100 = false;
      notifiedSpread_110 = false;
      notifiedSpread_120 = false;
      notifiedSpread_130 = false;
      notifiedSpread_140 = false;
      notifiedSpread_150 = false;
      notifiedSpread_175 = false;
      notifiedSpread_200 = false;
      notifiedSpread_225 = false;
      notifiedSpread_250 = false;
      notifiedSpread_275 = false;
      notifiedSpread_300 = false;
      notifiedSpread_325 = false;
      notifiedSpread_350 = false;
      notifiedSpread_375 = false;
      notifiedSpread_400 = false;
      notifiedSpread_425 = false;
      notifiedSpread_450 = false;
      notifiedSpread_475 = false;
      notifiedSpread_500 = false;
      
      dtReset = GetDateToday(dateReset);
   }
}
//+------------------------------------------------------------------+