Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277176AbRJDIZR>; Thu, 4 Oct 2001 04:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277177AbRJDIZH>; Thu, 4 Oct 2001 04:25:07 -0400
Received: from freerunner-o.cendio.se ([193.180.23.130]:20987 "EHLO
	mail.cendio.se") by vger.kernel.org with ESMTP id <S277176AbRJDIYy>;
	Thu, 4 Oct 2001 04:24:54 -0400
Date: Thu, 4 Oct 2001 10:25:27 +0200
Message-Id: <200110040825.KAA12270@reaktor.lkpg.cendio.se>
From: Magnus Redin <redin@ingate.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5    
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus writes:
> Note that the big question here is WHO CARES?

Everybody building firewalls, routers, high performance web servers
and broadband content servers with a Linux kernel.
Everyody having a 100 Mbit/s external connection. 

100 Mbit/s access is not uncommon for broadband access, at least in
Sweden. There are right now a few hundred thousand twisted pair Cat 5
and 5E installations into peoples homes with 100 Mbit/s
equipment. Most of them are right now throttled to 10 Mbit/s to save
upstream bandwidth but that will change as soon as we get more TV
channels on the broadband nets. Cat 5E cabling is specified to be able
to get gigabit into the homes to minimise the risk of the cabling
becoming worthless in 10 or 20 years.

A 100 Mbit/s untrusted connection is a reality for quite some people
and its not unreasonable for linux users when it cost $20-$30 per
month. The peering connection will probably be too weak with that
price but you still get thousandss of untrusted neighbours with a full
100 Mbit/s to your computer.

Btw, I work with production and customer support at a company building
linux based firewalls. I am unfortunately not a developer but it is
great fun to read the kernel mailinglist and watch misfeatures and
bugs being discovered, discussed and eradicated. Who need to watch
football when there is Linux VM battle of wits and engineering?

Best regards,
---
Magnus Redin  <redin@ingate.com>   Ingate - Firewall with SIP & NAT
Ingate System AB  +46 13 214600    http://www.ingate.com/

