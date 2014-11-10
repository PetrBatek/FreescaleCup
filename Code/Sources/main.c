#include "derivative.h" /* include peripheral declarations */
#include "TFC\TFC.h"

int main(void)
{
	uint32_t t,i=0;
	
	TFC_Init();
	
	for(;;)
	{	   
		//TFC_Task must be called in your main loop.  This keeps certain processing happy (I.E. Serial port queue check)
			TFC_Task();

			//This Demo program will look at the middle 2 switch to select one of 4 demo modes.
			//Let's look at the middle 2 switches
			switch((TFC_GetDIP_Switch()>>1)&0x03)
			{
			default:
			case 0 :
				//Demo mode 0 just tests the switches and LED's
				if(TFC_PUSH_BUTTON_0_PRESSED)
					TFC_BAT_LED0_ON;
				else
					TFC_BAT_LED0_OFF;
				
				if(TFC_PUSH_BUTTON_1_PRESSED)
					TFC_BAT_LED3_ON;
				else
					TFC_BAT_LED3_OFF;
				
				
				if(TFC_GetDIP_Switch()&0x01)
					TFC_BAT_LED1_ON;
				else
					TFC_BAT_LED1_OFF;
				
				if(TFC_GetDIP_Switch()&0x08)
					TFC_BAT_LED2_ON;
				else
					TFC_BAT_LED2_OFF;
				
				break;
					
			case 1:
				
				//Demo mode 1 will just move the servos with the on-board potentiometers
				if(TFC_Ticker[0]>=20)
				{
					TFC_Ticker[0] = 0; //reset the Ticker
					//Every 20 mSeconds, update the Servos
					TFC_SetServo(0,TFC_ReadPot(0));
					TFC_SetServo(1,TFC_ReadPot(1));
				}
				//Let's put a pattern on the LEDs
				if(TFC_Ticker[1] >= 125)
				{
					TFC_Ticker[1] = 0;
					t++;
					if(t>4)
					{
						t=0;
					}			
					TFC_SetBatteryLED_Level(t);
				}
				
				TFC_SetMotorPWM(0,0); //Make sure motors are off
				TFC_HBRIDGE_DISABLE;
			

				break;
				
			case 2 :
				
				//Demo Mode 2 will use the Pots to make the motors move
				TFC_HBRIDGE_ENABLE;
				TFC_SetMotorPWM(TFC_ReadPot(0),TFC_ReadPot(1));
						
				//Let's put a pattern on the LEDs
				if(TFC_Ticker[1] >= 125)
					{
						TFC_Ticker[1] = 0;
							t++;
							if(t>4)
							{
								t=0;
							}			
						TFC_SetBatteryLED_Level(t);
					}
				break;
			
			case 3 : // Camera	
				// TFC_Ticker[0] == miliseconds ; 1000 == 1s
				// pro pricitani musim nechat cyklus dobehnout => TFC_Task();
				
				// wait 2s - debug
				if(TFC_Ticker[0]<2000 || LineScanImageReady!=1){
					break;
				}
				else{
					TFC_Ticker[0] = 0;
				}
				
				// vypis hodnoty line camery
				for(i=0;i<128;i++)
				{
					TERMINAL_PRINTF("%d,",LineScanImage0[i]);
					
					// delay 10ms - pro spravny vypis na seriovy port
					TFC_Ticker[0] = 0;
					while(TFC_Ticker[0]<10){
						TFC_Task();
					}
				}
				TERMINAL_PRINTF("\r\n");
				
				/* TODO - oriznout a vyrovnat hodnoty, 
				 * tak aby mela bila barva na vsech pozicich stejnou hodnotu. 
				 * (Ted to tvori kopecek)
				*/
				
				// TODO - najit spocitat gradienty
				
				// TODO - najit podle gradientu hrany
				
				
			// Originalni kod
			/*	if(TFC_Ticker[0]>100 && LineScanImageReady==1)
					{
					 TFC_Ticker[0] = 0;
					 LineScanImageReady=0;
					 TERMINAL_PRINTF("\r\n");
					 TERMINAL_PRINTF("L:");
					 
					 	if(t==0)
					 		t=3;
					 	else
					 		t--;
					 	
						 TFC_SetBatteryLED_Level(t);
						
						 for(i=0;i<128;i++)
						 {
								 TERMINAL_PRINTF("%X,",LineScanImage0[i]);
						 }
						
						 for(i=0;i<128;i++)
						 {
								 TERMINAL_PRINTF("%X",LineScanImage1[i]);
								 if(i==127)
									 TERMINAL_PRINTF("\r\n",LineScanImage1[i]);
								 else
									 TERMINAL_PRINTF(",",LineScanImage1[i]);
						}										
							
					}*/
					


				break;
			}
	}
	
	return 0;
}
