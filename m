Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRDNAe5>; Fri, 13 Apr 2001 20:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132593AbRDNAer>; Fri, 13 Apr 2001 20:34:47 -0400
Received: from panchito.Austria.EU.net ([193.154.160.103]:61656 "EHLO
	relay3.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132545AbRDNAei>; Fri, 13 Apr 2001 20:34:38 -0400
Message-ID: <3AD79B1B.84F9F29D@eunet.at>
Date: Sat, 14 Apr 2001 02:34:35 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071507230.1561-100000@linux.local> <3ACF5E15.2A6E4F3C@eunet.at> <3ACF5FFE.24ECA0CA@mandrakesoft.com> <3AD04DA0.A1BC49B7@eunet.at> <3AD7830D.BD326BFE@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Michael Reinelt wrote:
> >
> > Thats clear to me. But the probe and remove routine can only be called
> > if the module is already loaded. My question was: who will load the
> > module? (I'll call it 'netmos.o')
> 
> typically a hotplug agent, cardmgr in this case.

huh? cardmgr?

I agree with the hotplug agent, but cardmgr? I know cardmgr and use it
on my laptop, but I've never heard of it dealing with PCI devices?
Doesn't he need some sort of 'card services' and stuff, none of them
available on a desktop PC?

bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
