Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTEMGKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTEMGKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:10:12 -0400
Received: from pop.gmx.net ([213.165.64.20]:30827 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263171AbTEMGKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:10:10 -0400
Date: Tue, 13 May 2003 08:20:28 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <71066878.1052813500@[192.168.1.249]>
References: <3191078.1052695705@[192.168.1.249]>
	<17308.1052658225@www4.gmx.net>
	<443147.1052742876@[192.168.1.249]>
	<200305120620.h4C6K64j061741@ns.indranet.co.nz>
	<71066878.1052813500@[192.168.1.249]>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S263171AbTEMGKK/20030513061010Z+8438@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003 08:11:40 +1200
Andrew McGregor <andrew@indranet.co.nz> wrote:

> 
> 
> --On Monday, 12 May 2003 8:17 a.m. +0200 Tuncer M zayamut Ayaz 
> <tuncer.ayaz@gmx.de> wrote:
> 
> 
> > one thing none of you most probably wants to hear:
> > if this "APM idle calls" is that "HLT" stuff, then I have to tell
> > you that on win32 I had not such problems while using the CpuIdle
> > tool. sorry.
> 
> No, HLT on idle is always on in Linux.  APM idle is a separate
> feature, which Windows never did (although Windows does do the
> equivalent thing with ACPI).
> 
> 
> > any PCMCIA fixes already available in linus -bk?
> 
> I don't know.
> 
> >
> > does CpuFreq depend on ACPI ? just in case i8k1 doesn't have proper
> > ACPI support.
> 
> No, it doesn't depend on ACPI.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

ok, so I'm unsubscribing now from LKML, as my problem seems to be
fixed in some way or other.
thanks to all of you for your assistance.
