Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262533AbSJHBPW>; Mon, 7 Oct 2002 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbSJHBPW>; Mon, 7 Oct 2002 21:15:22 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:8979 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262533AbSJHBPV>; Mon, 7 Oct 2002 21:15:21 -0400
Subject: Re: The end of embedded Linux?
From: "Xcytame@yahoo.es" <xcytame@yahoo.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>,
       giduru@yahoo.com, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1034033007.26504.44.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
	<20021005205238.47023.qmail@web13201.mail.yahoo.com>
	<20021005.212832.102579077.davem@redhat.com>
	<20021007092212.B18610@home.com>  <20021007230109.GI3485@conectiva.com.br> 
	<1034033007.26504.44.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Oct 2002 03:23:43 +0200
Message-Id: <1034040227.16163.32.camel@CRIPTA>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you said in a e-mail before, and also mentioned in the very
interesting book "Linux Device Drivers"  By Alessandro Rubini & Jonathan
Corbet , things should be done in the most simplest way. The reasons are
both avoid rewriting of code in order to optimize it, and also when
things are small you can control them  better and therefore your
hardware is better accesed.

Sorry about this little note from a kernel newbie to all the developers
out there if it makes you feel offended in some way.

> Submitting dprintk() seems like a great starting point. I've also got
> some patches in the archive someone sent that allows you to configure
> out the #! exec stuff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
