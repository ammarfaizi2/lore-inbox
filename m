Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbTBPRSA>; Sun, 16 Feb 2003 12:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBPRSA>; Sun, 16 Feb 2003 12:18:00 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:39910 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S267257AbTBPRR7>;
	Sun, 16 Feb 2003 12:17:59 -0500
Date: Sun, 16 Feb 2003 22:57:50 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling 
In-Reply-To: <Pine.LNX.4.50.0302161205240.578-100000@montezuma.mastecende.com>
Message-ID: <Pine.SOL.3.96.1030216225625.25827E-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Could you try updating to 2.5.61,

I am getting the same error even for 2.5.61

Please cc any replies to rahulv@csa.iisc.ernet.in

> 
> > When I tried to "make bzImage" the 2.5.53 it gave me the following error
> > 
> > In file included from include/linux/spinlock.h:13,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:4,
> >                  from include/linux/slab.h:14,
> >                  from include/linux/proc_fs.h:5,
> >                  from init/main.c:15:
> > include/linux/kernel.h:10:20: stdarg.h: No such file or directory
> > 
> > I am using gcc-3.2. And I did make menuconfig with default settings.
> > 
> > Please CC the Reply to my mail-id rahulv@csa.iisc.ernet.in
> 
> Could you try updating to 2.5.61, it is available at www.kernel.org with 
> mirrors at www.xx.kernel.org where xx is the country code of the mirror.
> 
> 	Zwane
> -- 
> function.linuxpower.ca
> 

