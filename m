Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271302AbTG2Hlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271312AbTG2Hlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:41:55 -0400
Received: from [195.206.1.27] ([195.206.1.27]:57617 "EHLO spidernet.it")
	by vger.kernel.org with ESMTP id S271302AbTG2Hlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:41:49 -0400
Date: Mon, 28 Jul 2003 23:45:23 +0200
From: adri <adri@archetti.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030728214523.GA485@inwind.it>
Mail-Followup-To: adri <adri@archetti.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
I have a problem compiling 2.6.0-test1, and later 2.6.0-test2.
booting the kernel goes well, but when i try to log in my system,
keyboard seems to be crazy, and when i press a key, it writes the same
key for almost 4 times, so it is very impossible log in.
/var/log/syslog don't seems to have something strange.
my system is a laptop hp pavilion ze4200, lspci tells me:
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M]
(rev 01)
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
IEEE-1394a-2000 Controller (PHY/Link)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
U1

i try to use 2.6.0-test1, test1-ac1, test1-mm1, test1-bk2, test2, with
always the same result.

is there someone who can help don't get crazy?

thanks
adri
-- 
icq# 63011800 - jabber: adri@jabber.org
gnupg key id: 4472FB13
"Non esiste vento favorevole per il marinaio che non sa dove andare."
Seneca
