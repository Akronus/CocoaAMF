//
//  DemoCaller.m
//  CocoaAMF-iPhone
//
//  Created by Marc Bauer on 11.01.09.
//  Copyright 2009 nesiumdotcom. All rights reserved.
//

#import "DemoCaller.h"


@implementation DemoCaller

@synthesize delegate=m_delegate;

#pragma mark -
#pragma mark Initialization & Deallocation

- (id)init
{
	if (self = [super init])
	{
		m_remotingCall = [[AMFRemotingCall alloc] init];
		m_remotingCall.URL = [NSURL URLWithString:@"http://192.168.1.10/almap/AMF/gateway.php"];
		m_remotingCall.service = @"Almap_ControllerOwners";
		m_remotingCall.delegate = self;
		m_delegate = nil;
	}
	return self;
}

- (void)dealloc
{
	[m_remotingCall release];
	[super dealloc];
}



#pragma mark -
#pragma mark Public methods

- (void)callGetOwnersMethod
{
	m_remotingCall.method = @"getOwners";
	m_remotingCall.arguments = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], 
								[NSNumber numberWithInt:3], nil];
	[m_remotingCall start];
}

- (void)callAddMethod
{
	m_remotingCall.method = @"add";
	m_remotingCall.arguments = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], 
		[NSNumber numberWithInt:3], nil];
	[m_remotingCall start];
}

- (void)callHelloMethod
{
	m_remotingCall.method = @"hello";
	m_remotingCall.arguments = [NSArray array];
	[m_remotingCall start];	
}

- (void)callReturnArrayMethod
{
	m_remotingCall.method = @"returnArray";
	m_remotingCall.arguments = [NSArray array];
	[m_remotingCall start];	
}

- (void)callReturnFloatMethod
{
	m_remotingCall.method = @"returnFloat";
	m_remotingCall.arguments = [NSArray array];
	[m_remotingCall start];
}



#pragma mark -
#pragma mark AMFRemotingCall Delegate methods

- (void)remotingCallDidFinishLoading:(AMFRemotingCall *)remotingCall 
	receivedObject:(NSObject *)object
{
	objc_msgSend(m_delegate, @selector(callerDidFinishLoading:receivedObject:), self, object);
}

- (void)remotingCall:(AMFRemotingCall *)remotingCall didFailWithError:(NSError *)error
{
	objc_msgSend(m_delegate, @selector(caller:didFailWithError:), self, error);
}

@end