Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTD2GEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 02:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbTD2GEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 02:04:08 -0400
Received: from [193.89.230.30] ([193.89.230.30]:44936 "EHLO
	roadrunner.hulpsystems.net") by vger.kernel.org with ESMTP
	id S261960AbTD2GEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 02:04:07 -0400
Message-ID: <1051596982.3eae18b640303@roadrunner.hulpsystems.net>
Date: Tue, 29 Apr 2003 08:16:22 +0200
From: Martin List-Petersen <martin@list-petersen.dk>
To: bas.mevissen@hetnet.nl
Cc: linux-kernel@vger.kernel.org
Subject: RE: Broadcom BCM4306/BCM2050  support
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I couldn't find any Linux support for these WLAN chips with 
> google or on this lists archives. So I would like to ask it here:

It seems, that the specs haven't been released yet. There are quite a few Wlan
cards out there based on the Broadcom chips (nearly all cards, that support
802.11g), so it's quite a shame. (Actually this fits the the TrueMobile 1180,
1300 and 1400, speaking of Dell wireless lan cards).

> Is there somebody working on a Linux driver for the Broadcom 
> BCM4306/BCM2050 chips? They are used for instance in the 
> built-in Dell TrueMobile 1300 Wireless LAN PCI card that is 
> sold for Dell notebooks. I've ordered a Dell Inspiron 8500 
> with such thing in it. (had to choose Dell and the i8500 was 
> the best choice at the moment).

The same problem is with the Intel Prowireless 2100 (Centrino) WLan card. No
Linux support available yet, which is another choice for the Dell notebooks at
the moment.

> I read on 
> <http://www.ee.surrey.ac.uk/Personal/G.Wilford/Inspiron8500>
>  that the Ethernet chip (BCM4401) is support by a Broadcom driver and a brand
> new one from Daved S. Miller.

The ethernet chip is supported both by the BCM5700 and the Tigon3 drivers. It's
basically the same chipset family, that Dell has used in their servers for quite
a while and since these are delivered with Linux of the factory, the driver has
been around for quite a while.

> So I'm wondering if Broadcom is willing to release specs for the WLAN chips 
> too.

Not so far. There is a petition here on exactly that issue:
http://www.petitiononline.com/BCM4301/petition.html

> How are the experiences in contacting Broadcom and Dell with requests for
> help?

Dell won't be able to help you at the moment, since Linux on notebooks is
supported on a "best effort" basis, but not delivered with the notebooks of
factory. So no demand for drivers here. 

I've tried to contact Broadcom directly, but they are just ignoring mails
containing the word "Linux", so it seems.

Regards,
Martin List-Petersen
martin at list-petersen dot dk
--
Stop searching.  Happiness is right next to you.  Now, if they'd only
take a bath ...

