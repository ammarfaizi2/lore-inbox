Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTHaXmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTHaXmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:42:11 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:20789 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S263064AbTHaXmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:42:01 -0400
Message-ID: <3F5287BC.48A1BCE6@vtc.edu.hk>
Date: Mon, 01 Sep 2003 07:41:48 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble??
References: <3F4EA30C.CEA49F2F@vtc.edu.hk>
	 <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F4F5C9A.5BAA1542@vtc.edu.hk> <200308311443.55543.hpj@urpla.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Whitelist: YES (by domain whitelist at pandora.vtc.edu.hk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,

Hans-Peter Jansen wrote:

> Hi Nick,
>
> On Friday 29 August 2003 16:00, Nick Urbanik wrote:
> >
> > Performance is a relatively minor issue compared with stability and
> > low cost.
> >
> > Is there _anyone_ who is using a number of ATA133 IDE disks (>=6),
> > each on its own IDE channel, on a number of PCI IDE cards, and
> > doing so successfully and reliably?  I begin to suspect not!  If
> > so, please tell us what motherboard, IDE cards you are using.  I
> > used to imagine that a terabyte of RAID storage on one P4 machine
> > with ordinary cheap IDE cards with software RAID would be feasible.
> >  I believe it is not (although I cannot afford to play musical
> > motherboards).
>
> It is. I'm running several pretty stable systems with IDE SW RAID 5
> on top of Promise TX2/100 (~30 Eur) controllers.

Is that the PDC20270 chipset?  What motherboard are you using (i.e., I guess
you are using two IDE channels on the motherboard, so what chipset are you
using there)?  What kernel?  Are you using ide-scsi at the same time?  A DVD
player?  If so, how have you connected them?  What is the biggest number of
hard disks you are using?  What size?

I would like to try this out myself.  Thank you---this is the first success
story I have heard!

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



