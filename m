Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRHRMyZ>; Sat, 18 Aug 2001 08:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRHRMyO>; Sat, 18 Aug 2001 08:54:14 -0400
Received: from chmls20.mediaone.net ([24.147.1.156]:40440 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S270132AbRHRMxy> convert rfc822-to-8bit; Sat, 18 Aug 2001 08:53:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andy Stewart <andystewart@mediaone.net>
Organization: Worcester Linux Users' Group
To: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.9 locks up solidly with USB and SMP
Date: Sat, 18 Aug 2001 08:54:06 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <01081800562800.08460@tux> <20010818125124.A8896@se1.cogenit.fr>
In-Reply-To: <20010818125124.A8896@se1.cogenit.fr>
Cc: andystewart@mediaone.net
MIME-Version: 1.0
Message-Id: <01081808540600.06887@tux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Saturday 18 August 2001 06:51, Francois Romieu wrote:
> Andy Stewart <andystewart@mediaone.net> :
> [...]
>
> > With kernel version 2.4.9, my system locks up solidly when I run with
> > SMP enabled and attempt to print anything to my USB printer.   I have
> > seen this behavior for the last few kernel revs.
>
> Could you pass "nmi_watchdog=1" as an argument to the kernel during the
> boot and see if you get an Oops this way ?

I tried this and did not see any printout on my screen.  I waited over a 
minute after the lockup before rebooting.  There's nothing in the system 
log file, either.  Just hard lockup.  :-(

Thank you for the suggestion.

Andy

-- 
Andy Stewart
Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

