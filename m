Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292984AbSB0Xdi>; Wed, 27 Feb 2002 18:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293061AbSB0XdE>; Wed, 27 Feb 2002 18:33:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293059AbSB0Xc0>; Wed, 27 Feb 2002 18:32:26 -0500
Subject: Re: disk transfer speed problem
To: wolfy@pcnet.ro (lonely wolf)
Date: Wed, 27 Feb 2002 23:46:42 +0000 (GMT)
Cc: hahn@physics.mcmaster.ca (Mark Hahn), linux-kernel@vger.kernel.org
In-Reply-To: <3C7D632C.46CE687@pcnet.ro> from "lonely wolf" at Feb 28, 2002 12:52:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gDmU-0006PG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  Timing buffered disk reads:  64 MB in  3.24 seconds = 19.75 MB/sec
> >
> > well, 109 MB/s is pretty low for buffer-cache reads; this reflects
> > the relative crippled-ness of your cpu/dram/chipset.
> 
> well... i would't name a Celeron 900 MHz crippled. PC133 is the best the
> board gets... and now the speed is lower then the previous server which was
> an Athlon 600 pluggede in an Asus VIA KX133 based mobo.

I get 25MB/sec off my i815 board. It is pretty starved - I seem stuck at
about 25MB/sec total even doing hdparm across both controllers.

Using an external video card might make a small difference
