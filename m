Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBBKmU>; Fri, 2 Feb 2001 05:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbRBBKmK>; Fri, 2 Feb 2001 05:42:10 -0500
Received: from expanse.dds.nl ([194.109.10.118]:21522 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129078AbRBBKlw>;
	Fri, 2 Feb 2001 05:41:52 -0500
Date: Fri, 2 Feb 2001 11:41:02 +0100
From: Ookhoi <ookhoi@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: vaio doesn't boot with 2.4.1-ac1, stops at PCI: Probing PCI hardware
Message-ID: <20010202114102.E484@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
X-Uptime: 1:01pm  up 5 min,  3 users,  load average: 0.07, 0.14, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel 2.4.1-ac1 doesn't boot on a vaio c1ve (crusoe). I boot a kernel
via the usb floppy drive, and it ends with:

...
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware

Here it hangs hard. It used to boot with 2.4.0 and 2.4.1-prex  Should I
try to determine which patch made the fatal change? Should I send my
.config? Is there something I can try? Tia!

		Ookhoi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
