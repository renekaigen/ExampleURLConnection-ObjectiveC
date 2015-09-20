//
//  ViewController.m
//  ejemploConexion
//
//  Created by René Soto Lira on 19/09/15.
//  Copyright (c) 2015 KAI. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"//importo el delegado


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /*HACIENDO LA CONEXION*/
    NSURL *aUrl = [NSURL URLWithString:@"http://pastebin.com/raw.php?i=Xtnh34eu"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    
    
    [request setHTTPMethod:@"POST"];
    //NSString *postString = @"servicio=test&accion=obtenAlumnos";
    //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection;
    connection= [[NSURLConnection alloc] initWithRequest:request
                                                delegate:self];

}

/*==== METODOS DE CONEXION ===*/

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _urlData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_urlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *jsonParsingError = nil;
    //id object = [NSJSONSerialization JSONObjectWithData:_urlData options:0 error:&jsonParsingError];
    NSString *resultado = [[NSString alloc] initWithData:_urlData encoding:NSUTF8StringEncoding];
    //NSLog(@"resultado: %@",resultado);
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: _urlData options: 0 error: &jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
    } else {
        //NSLog(@"OBJECT: %@", [jsonDictionary description]);
        
        
        //NSLog(@"TIPO: %@", [jsonDictionary class]);
        
        
        NSArray *RestaurantArray = [jsonDictionary objectForKey:@"restaurantes"];
        
        //AppDelegate *appdelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        //NSFetchRequest *fetch1=[[NSFetchRequest alloc] init];
        //NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Restaurantes" inManagedObjectContext:[appdelegate managedObjectContext]];
        
        
        for(int i=0; i<RestaurantArray.count; i++)
        {
            
            NSDictionary *RestaurantActual =[RestaurantArray objectAtIndex:i];
            
            
            
            // NSLog(@"restaurant: %@", [RestaurantActual description]);
            
            NSLog(@"nombre: %@", [RestaurantActual objectForKey:@"nombre"]);
            
            NSArray *platillosRestaurant =[RestaurantActual objectForKey:@"platillos"];
            
            for(int j=0; j<platillosRestaurant.count; j++)
            {
                NSDictionary *nombrePlatillo=[platillosRestaurant objectAtIndex:j];
                NSLog(@"platilos: %@", [nombrePlatillo objectForKey:@"nombre"]);
                
            }
            
            
        }
        
        
        
        
        // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"hola" message:[[jsonArray objectAtIndex:0]description] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        //[alert show];
        
        
        
        // comienza codigo para verificar si existe en la base de datos
        
        // primero checo los nombres de los restaurantes
        
        
        
        
        
        
    }
}

/*=== TERMINAN metodos de conexion*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
