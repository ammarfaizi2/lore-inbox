Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSHRCib>; Sat, 17 Aug 2002 22:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318803AbSHRCib>; Sat, 17 Aug 2002 22:38:31 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:10368 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318799AbSHRCib>;
	Sat, 17 Aug 2002 22:38:31 -0400
Date: Sat, 17 Aug 2002 21:35:29 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <5.1.0.14.2.20020817225323.021796b0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0208172127170.1238-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Anton Altaparmakov wrote:

> At 20:56 17/08/02, Alan Cox wrote:
> >Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
> >controllers would also be much appreciated. That way we can get good
> >coverage tests and catch badness immediately
> 
> If you tell me the kernel version and patches to apply which you want 
> tested, and what options to run cerberus with (never used it before...), I 
> have control over a currently idle dual Athlon MP 2000+ with an AMD-768 
> (rev 04) IDE controller and 3G of RAM. It has only one HD, a ST340810A 
> (ATA-100, 37G) attached.
> 
> btw. Is this where I get cerberus from?
>          http://sourceforge.net/projects/va-ctcs/
> 
> The machine won't be in use for a few more weeks (until I find the time to 
> configure all the software and the database server it will be connecting 
> to...) so I can do tests during that period.

I'm not familiar with Cerebus, but I'm willing to pitch in with any 
testing you feel necessary.  I just finished rebuilding my system with 
removable hard drives, originally to beat against Martin's IDE code.  I 
now have a known good stable system I can do production with as well as a 
dev drive I can restore to pristine in about 15 minutes.  System is an 
Athlon 1.3 GHz on Asus A7V with 384MB RAM.

Is it going to be more desireable to beat on 2.4 IDE or 2.5 IDE?  

