Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272395AbRHYHMo>; Sat, 25 Aug 2001 03:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271000AbRHYHMX>; Sat, 25 Aug 2001 03:12:23 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:46196 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S271063AbRHYHMW>; Sat, 25 Aug 2001 03:12:22 -0400
Date: Sat, 25 Aug 2001 09:12:26 +0200
From: Cliff Albert <cliff@oisec.net>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 broken on 486SX
Message-ID: <20010825091226.A18300@oisec.net>
In-Reply-To: <3B86BAF0.489E92C6@didntduck.org> <20010825024627.30130.qmail@web10404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010825024627.30130.qmail@web10404.mail.yahoo.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 12:46:27PM +1000, Steve Kieu wrote:

> By the way, I got this strange thing too but with
> 2.2.19. I got the kernel 2.2.19 source from slackware
> site, compile it using gcc 2.95.3 and select CPU as
> 486, but the compiled image can not run in my 486 CPU
> (it does run fine in the machine I compile it i686).
> There is no way. Ironically 2.4.x works for me, if I
> choose 486, I can run it on 486. 
> 
> I noticed the differrence in the cflags in 2.2.19 it
> is like  -m486 -DCPU=i486  and in 2.4.x it is
> -march=i486 instead of -DCPU=i486. According to gcc
> documentation it is the same. Why it is like that ? 

Linux 2.4.8-ac3 runs just fine on my Compaq Prosignia VS (which has a 486DX66)

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
