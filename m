Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288710AbSADSMg>; Fri, 4 Jan 2002 13:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288711AbSADSMc>; Fri, 4 Jan 2002 13:12:32 -0500
Received: from mustard.heime.net ([194.234.65.222]:35507 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288710AbSADSMW>; Fri, 4 Jan 2002 13:12:22 -0500
Date: Fri, 4 Jan 2002 19:12:17 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error loading e1000.o - symbol not found
In-Reply-To: <3C35EFCC.52E7BFD9@redhat.com>
Message-ID: <Pine.LNX.4.30.0201041912080.30049-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Arjan van de Ven wrote:

> Roy Sigurd Karlsbakk wrote:
> >
> > hm...
> >
> > same problem with 2.4.18-pre1
> >
> > [root@vs2 src]# modprobe e1000
> > /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: unresolved symbol _mmx_memcpy
> > /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: insmod
> > /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o failed
> > /lib/modules/2.4.18-srv1/kernel/drivers/net/e1000.o: insmod e1000 failed
> >
> > anyone that knows why?
>
> Intel probably uses the wrong set of kernel headers to compile against
>

do you know how I can fix it?

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

