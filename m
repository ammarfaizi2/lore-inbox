Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSHOP7v>; Thu, 15 Aug 2002 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHOP7v>; Thu, 15 Aug 2002 11:59:51 -0400
Received: from email.careercast.com ([216.39.101.233]:15082 "HELO
	email.careercast.com") by vger.kernel.org with SMTP
	id <S317215AbSHOP7u>; Thu, 15 Aug 2002 11:59:50 -0400
Subject: Re: RedHat 7.3 kernel fix
From: Matt Simonsen <matt_lists@careercast.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1029373201.28236.2.camel@irongate.swansea.linux.org.uk>
References: <1029371653.26279.39.camel@mattswork> 
	<1029373201.28236.2.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 15 Aug 2002 09:03:43 -0700
Message-Id: <1029427423.26563.68.camel@mattswork>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 18:00, Alan Cox wrote:
> On Thu, 2002-08-15 at 01:34, Matt Simonsen wrote:
> > At this point the machine known good hardware, although I moved some RAM
> > into it along with the OS move and I'm just not sure where to go. It's
> 
> So you moved some RAM and it started crashing randomly. Does it pass
> memtest 86 (3.0 or higher for ECC RAM)


I wouldn't say I moved RAM and it just started crashing - I also did an
upgrade from RedHat 6.2 w/ 2.4.17 kernel to a stock (and patched) RedHat
7.3 setup. I was suspecting maybe the kernel fix didn't work or
something - but it does register as 2.4.18-5.... I suppose that is just
wishful thinking so we don't have to swap out the machine.

At this point it seems clear I need to swap out the hardware, if not for
any other reason because it is a production machine so I can't run
memtest 86 just yet. 

On the new machine I suppose I will run the stock RedHat kernel. If the
replacement crashes, perhaps I will switch kernels and see if it
persists.

Thanks for your reply-
Matt




> 
> Alan
> 


