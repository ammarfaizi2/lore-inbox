Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRIEQ0l>; Wed, 5 Sep 2001 12:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRIEQ0d>; Wed, 5 Sep 2001 12:26:33 -0400
Received: from mail.galileo.edu ([168.234.203.4]:43534 "EHLO mail.galileo.edu")
	by vger.kernel.org with ESMTP id <S269756AbRIEQ0X>;
	Wed, 5 Sep 2001 12:26:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: kernel panic, a cry for help
Message-ID: <999707202.3b965242145d5@webmail.galileo.edu>
Date: Wed, 05 Sep 2001 10:26:42 -0600 (CST)
From: oscarcvt@galileo.edu
In-Reply-To: <E15efKa-0006Cj-00@the-village.bc.nu>
In-Reply-To: <E15efKa-0006Cj-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 200.12.38.74
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ive started with a rescue disk, /sbin/init is present, lilo.conf seems fine, 
where might i go next?

thanx to all,
oscar


> > im not sure if this q belongs here but i need all the help i can get.
> > the www, dns, mail server at my site mysteriously got corrupted (not
> sure how). 
> > Now i boot it up and get
> > 
> > Kernel panic: No init found. Try passing init= option to kernel
> > 
> > what can i do? where should i start? i dont want to break anything so
> please 
> > help me,
> 
> I suspect back up tapes. The kernel cannot find an /sbin/init to run
> when
> it starts up. That could be on of several things
> 
> 	-	Disk failure
> 	-	Someone broke in and erased it all
> 	-	Misconfiguration
> 
> A rescue disk is probably the starting point
> 
