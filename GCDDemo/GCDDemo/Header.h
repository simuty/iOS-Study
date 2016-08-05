//
//  Header.h
//  GCDDemo
//
//  Created by HHW-HHW on 16/6/29.
//  Copyright © 2016年 Starming. All rights reserved.
//

#ifndef Header_h
#define Header_h


#if 1
#define NSLog(FORMAT, ...) fprintf(stderr,"-------\nfunction:%s \nline:%d \ncontent:%s\n+++++++++++++++", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif



#endif /* Header_h */
