Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbRBBXBc>; Fri, 2 Feb 2001 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130657AbRBBXBX>; Fri, 2 Feb 2001 18:01:23 -0500
Received: from main.cyclades.com ([209.128.87.2]:4362 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S130347AbRBBXBH>;
	Fri, 2 Feb 2001 18:01:07 -0500
Date: Fri, 2 Feb 2001 15:01:05 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.2.18: weird eepro100 msgs
Message-ID: <Pine.LNX.4.10.10102021500450.3255-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

The system is as follows:
- Intel CA810EAL motherboard (built-in EtherExpress Pro 10/100)
- 128MB RAM
- 10GB IDE HD (Western Digital WD100)
- Linux kernel 2.2.18

Sometimes when I reboot the system, as soon as the eepro100 module is
loaded, I start to get these msgs on the screen:

eth0: card reports no resources.
eth0: card reports no RX buffers.
eth0: card reports no resources.
eth0: card reports no RX buffers.
eth0: card reports no resources.
eth0: card reports no RX buffers.
(...)

They go on forever, and the box becomes inoperational (I can see the msgs
on the screen, but I can't login, type anything ...). If I reboot the
system, the msgs do NOT show up anymore, and then I can use the system
again.

Could anyone _please_ shed a light on this one for me?!?! How could I
solve it?? What kind of additional info you need?? Please let me know.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
