Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270221AbRHWTxI>; Thu, 23 Aug 2001 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRHWTw6>; Thu, 23 Aug 2001 15:52:58 -0400
Received: from imo-d07.mx.aol.com ([205.188.157.39]:16045 "EHLO
	imo-d07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S270221AbRHWTww>; Thu, 23 Aug 2001 15:52:52 -0400
Date: Thu, 23 Aug 2001 15:52:54 -0400
From: schemins@netscape.net (Thunder from the hill)
To: linux-kernel@vger.kernel.org
Subject: ne2k-pci crash on ifconfig
Message-ID: <099D519D.3FD237C3.00A6DFE2@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a rtl8029 PCI ethernet card. The driver works fine, the netcard is detected, but when ifconfig is executed on eth0, the system locks up. I had used a ne2k-isa (ne) netcard before, and it worked just fine. But I can't stick back to this card, and I want to know if there is something known about this crash.
I cannot append my settings, as I have no connection from the server to anywhere else. The most important things:
K6-II 400, 100 MHz BUS, 384 MB of RAM, 13.6 GB harddisk, Voodoo II Banshee card, SB Live! Full, RTL8029 NIC, IPv4, IPv6, PCI access mode: any
Anything more to be known?

Thunder

-- 
---
Woah! I did a "cat /boot/vmlinuz >> /dev/audio", and I think I heard god...



__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

