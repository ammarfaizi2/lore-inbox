Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRCVPOa>; Thu, 22 Mar 2001 10:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132055AbRCVPOX>; Thu, 22 Mar 2001 10:14:23 -0500
Received: from staffnet.com ([207.226.80.14]:24079 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S132058AbRCVPOE>;
	Thu, 22 Mar 2001 10:14:04 -0500
Message-ID: <3ABA1680.D1467727@staffnet.com>
Date: Thu, 22 Mar 2001 10:13:04 -0500
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: regression testing
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nbecker@fred.net wrote:
> 
> Hi.  I was wondering if there has been any discussion of kernel
> regression testing.  Wouldn't it be great if we didn't have to depend
> on human testers to verify every change didn't break something?
IMHO, much of the strength of Linux is the very large, extremely 
diverse population of folks using it, testing it, beating on 
the latest release, etc.  

However, a lab dedicated to testing the linux kernel, properly 
funded, staffed, and containing the most common hardware and 
software would be a good idea.  Does anyone have any idea how
this could be accomplished?  Who could do it?  IBM?  What would
it cost to setup a reasonable lab?  My guess would be dozens 
of machines of various architectures, a staff of at least 10,
several thousand square feet of space, and a good budget....
Any takers?  

Much of the kernel COULD be tested such as file systems, network 
stack, SMP, compile options on various platforms, etc.  More
obscure hardware, some older hardware, etc., would be out of 
scope for such an effort.

Cheers,
-- 
W. Wade, Hampton  <whampton@staffnet.com>  
If Microsoft Built Cars:  Every time they repainted the 
lines on the road, you'd have to buy a new car.
Occasionally your car would just die for no reason, and 
you'd have to restart it, but you'd just accept this.
