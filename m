Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVHSTdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVHSTdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVHSTdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:33:21 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:12257 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S965016AbVHSTdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:33:20 -0400
Message-ID: <430633A1.8030009@dresco.co.uk>
Date: Fri, 19 Aug 2005 20:31:45 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [patch] libata passthrough - return register data from HDIO_*
 commands
References: <42FE2FBA.3000605@dresco.co.uk> <430112F6.3090906@dresco.co.uk> <20050819190625.GB2736@tuxdriver.com> <20050819191902.GC2736@tuxdriver.com>
In-Reply-To: <20050819191902.GC2736@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Pythagoras-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:

>On Fri, Aug 19, 2005 at 03:06:27PM -0400, John W. Linville wrote:
>  
>
>>On Mon, Aug 15, 2005 at 11:11:02PM +0100, Jon Escombe wrote:
>>    
>>
>>>>Here is a first attempt at a patch to return register data from the 
>>>>libata passthrough HDIO ioctl handlers, I needed this as the ATA 
>>>>'unload immediate' command returns the success in the lbal register. 
>>>>        
>>>>
>
>  
>
>>Overall, I like the patch.  I trust your assertion that it actually
>>works... :-)
>>
>>I have a few comments...
>>    
>>
>
>Well, apparently "Jon Escombe <lists@dresco.co.uk>" is not a good
>address.  I got a delivery failur notification email from his mail
>server.  Hopefully Jon reads the lists... :-)
>
>John
>  
>
Thanks, will take a look at the comments.

Not sure why the email bounced, but I will give you another email 
address so you could forward me the notification (if you still have it?)

Regards,
Jon.


______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
