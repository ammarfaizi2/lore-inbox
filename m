Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRBCUWF>; Sat, 3 Feb 2001 15:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbRBCUVq>; Sat, 3 Feb 2001 15:21:46 -0500
Received: from mail11.jump.net ([206.196.91.11]:49302 "EHLO mail11.jump.net")
	by vger.kernel.org with ESMTP id <S130016AbRBCUVh>;
	Sat, 3 Feb 2001 15:21:37 -0500
Message-ID: <3A7C686A.2B69D222@sgi.com>
Date: Sat, 03 Feb 2001 14:22:02 -0600
From: Eric Sandeen <sandeen@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-XFS i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "kaweth" usb ethernet driver in 2.4?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering about the status of the "kaweth" Kawasaki LSI KL5KUSB100
USB to Ethernet Controller driver for 2.4.  According to
http://www.hiru.aoba.yokohama.jp/%7eura/USB/usbether.html, this chipset
is used in the 3Com USB Network Adapter, Linksys USB10T, D-Link DSB-650,
SMC 2102USB, Netgear EA101, and a few other USB ethernet adapters.

The driver is included with the USB stuff for 2.2, but not in 2.4.

It also doesn't seem to work in 2.2.  :)  The original development of
this driver was going on at http://drivers.rd.ilan.net/kaweth/ but there
have been no updates for quite some time.

Donald Becker had a driver at one point as well, and there's still a
link at http://www.scyld.com/usb/ethernet.html, but the link is broken
now, and I don't have the code.

I have one of these beasts, and I'd like to get it working - I haven't
done any USB _or_ ethernet work for Linux, so it'll be an uphill climb
fro me.  Anybody else have one, and have some time to collaborate?  :) 
I have some of the chipset documentation, too, FWIW.

Thanks,
-Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
