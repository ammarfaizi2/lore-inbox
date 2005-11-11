Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVKKGhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVKKGhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 01:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVKKGhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 01:37:25 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:40093
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750848AbVKKGhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 01:37:24 -0500
Message-ID: <43743C18.8090309@linuxwireless.org>
Date: Fri, 11 Nov 2005 00:37:12 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Kernel Panic 2.6.14-git (pictures)
References: <20051110151214.M35138@linuxwireless.org> <1131680001.24968.4.camel@phantasy> <43743893.9080100@linuxwireless.org> <200511110131.57845.dtor_core@ameritech.net>
In-Reply-To: <200511110131.57845.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On Friday 11 November 2005 01:22, Alejandro Bonilla Beeche wrote:
>  
>
>>Robert Love wrote:
>>
>>    
>>
>>>On Thu, 2005-11-10 at 17:55 -0800, Andrew Morton wrote:
>>>
>>> 
>>>
>>>      
>>>
>>>>Yes, photos of the screen work very nicely, thanks.
>>>>   
>>>>
>>>>        
>>>>
>>>Excellent!
>>>
>>> 
>>>
>>>      
>>>
>>>>Hi, Robert ;)
>>>>   
>>>>
>>>>        
>>>>
>>>Andrew.  ;-)
>>>
>>>Alejandro - there is Dmitry Torokhov that fixed this and I thought it
>>>went in Linus's tree (it was in Greg's tree and he pushed it over a week
>>>ago).
>>>
>>>Dmitry?
>>> 
>>>
>>>      
>>>
>>LOL, everyone is pointing to someone else... ;-)
>>
>>    
>>
>
>Heh ;)
>
>Alejandro, didn't you have another issue with pcspeaker driver in
>conjunction with PNP? Did my patch moving inpu core into a separate
>directory and registering it early help?
>  
>
That wasn't me. ;-| It has always been about this hdaps module I 
think... now it became a panic, before was just an oops.

> 
>  
>
>>Linus, can you please merge Dmitry's patch? ;o
>>
>>    
>>
>
>Thank you for testing it!
>  
>
Sure, I gotta help in something! ;-)

.Alejandro

