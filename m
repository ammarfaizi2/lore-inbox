Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132507AbRDRSjC>; Wed, 18 Apr 2001 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135225AbRDRSix>; Wed, 18 Apr 2001 14:38:53 -0400
Received: from virtualro.ic.ro ([194.102.78.138]:33284 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S132507AbRDRSip>;
	Wed, 18 Apr 2001 14:38:45 -0400
Date: Wed, 18 Apr 2001 21:38:40 +0300 (EEST)
From: Jani Monoses <jani@virtualro.ic.ro>
To: Ben Pfaff <pfaffben@msu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rage Mobility P/M
In-Reply-To: <874rvmrraa.fsf@pfaffben.user.msu.edu>
Message-ID: <Pine.LNX.4.10.10104182137100.1670-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I only use it with vesafb,but ywrap is doing strange stuff
(maybe the card misreports the amount of memory on it) and redraw
and ypan are sloooow... 

On 18 Apr 2001, Ben Pfaff wrote:

> Jani Monoses <jani@virtualro.ic.ro> writes:
> 
> > 	does the atyfb or aty128fb  support this chip?
> > Device id of 4c4d.
> > Using 2.4.3-ac7.
> 
> I have a Rage Mobility with the same device ID on my laptop
> (Compaq Armada M700) but haven't been able to get it working with
> framebuffer.  At any rate, atyfb is the proper one to use.  Let
> me know if you get it working, I'd like to use it too.
> -- 
> "How could this be a problem in a country 
>  where we have Intel and Microsoft?"
> --Al Gore on Y2K
> 

