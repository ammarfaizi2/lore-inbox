Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDMPkW>; Fri, 13 Apr 2001 11:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRDMPkM>; Fri, 13 Apr 2001 11:40:12 -0400
Received: from stanis.onastick.net ([207.96.1.49]:59143 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S131407AbRDMPkD>; Fri, 13 Apr 2001 11:40:03 -0400
Date: Fri, 13 Apr 2001 11:39:52 -0400
From: Disconnect <dis@sigkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Moses Mcknight <moses@texoma.net>, linux-kernel@vger.kernel.org
Subject: Re: Problem with k7 optimizations in 2.4.x?
Message-ID: <20010413113952.F21462@sigkill.net>
In-Reply-To: <3AD706C4.8020705@texoma.net> <E14o5Wc-000336-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14o5Wc-000336-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the iwill mobo? (I haven't heard of this problem on other
motherboards.)

I'll grab the latest -ac today and give it a try this evening. 

(Just for reference, the system is the Iwill kk266, 1.2G tbird, 512M
pc133, ata66 drive - everything has AMD-approved stickers and nothing is
overclocked.)

On Fri, 13 Apr 2001, Alan Cox did have cause to say:

> > settings or what, but whenever I try to run a 2.4.x kernel on my machine 
> > with k7 optimizations the computer will never fully boot and seems to 
> > give random errors about being "unable to handle kernel NULL pointer 
> > dereference at virtual address xxxxxxxx" and other errors.
> 
> I run the K7 optimisations in 2.4.x-ac built with gcc 2.96-69 or later with no
> problems. I've not tested them with egcs-1.1.2. The earlier 2.4.* had problems
> on later Athlons which have both fxsave and movntq/sfence. That was fixed a 
> while back tho
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
