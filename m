Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNLJL>; Thu, 14 Dec 2000 06:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQLNLJC>; Thu, 14 Dec 2000 06:09:02 -0500
Received: from jalon.able.es ([212.97.163.2]:57988 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129773AbQLNLIq>;
	Thu, 14 Dec 2000 06:08:46 -0500
Date: Thu, 14 Dec 2000 11:38:13 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mircea Damian <dmircea@linux.kappa.ro>, linux-kernel@vger.kernel.org
Subject: Re: do NOT compile 2.2.18 with egcs-1.1.2
Message-ID: <20001214113813.C9662@werewolf.able.es>
In-Reply-To: <20001214102145.B17934@linux.kappa.ro> <E146VXg-00045d-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E146VXg-00045d-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 11:23:14 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Dec 2000 11:23:14 Alan Cox wrote:
> > I just want to let other know that kernel 2.2.18 does not work properly (*)
> > on my box if I compile it with egcs-2.91.66 19990314/Linux (egcs-1.1.2
> > release). Instead gcc-2.7.2.3 works ok.
> > 
> > (*) the network driver PCI NE2000 does not work with all three cards. It
> > just sees them but they do not work.
> 
> I don't believe that is likely to be the reason. The driver has not changed
> since 2.2.15 if not earlier, and it still seems to work with the cards I have
> here (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> 
> Alan

I use 2.2.18 with ne2k-pci from kernel and that of scyld, and work fine under
2.91 (egcs)

BTW, when a resync of 2.2 net drivers with scyld ? perhaps 2.2.19 ? 

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa1 #1 SMP Mon Dec 11 21:26:28 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
