Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289578AbSAVXme>; Tue, 22 Jan 2002 18:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289580AbSAVXmP>; Tue, 22 Jan 2002 18:42:15 -0500
Received: from h225-81.adirondack.albany.edu ([169.226.225.80]:8832 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S289578AbSAVXmH>;
	Tue, 22 Jan 2002 18:42:07 -0500
Date: Tue, 22 Jan 2002 18:42:01 -0500
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Subject: via-rhine timeouts
Message-ID: <20020122234201.GA835@bouncybouncy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting many errors due to timeouts, everything was fine while
I was at home, but here at school it's a major problem:

Jan 22 18:10:00 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:00 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY 
status 782d, resetting...
Jan 22 18:10:10 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:10 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY 
status 782d, resetting...
Jan 22 18:10:18 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:18 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY 
status 782d, resetting...
Jan 22 18:10:26 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:26 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY 
status 782d, resetting...
Jan 22 18:10:34 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit
timed out
Jan 22 18:10:34 bouncybouncy kernel: eth0: Transmit timed out, status
0000, PHY 
status 782d, resetting...

Jan 22 18:10:34 bouncybouncy kernel: eth0: reset did not complete in 10
ms.

once it complains about that, it stops working until I reboot.

It seems to happen everytime a large transer is done.(apt-get updgrade
-d the last 3 times.)

Is this a problem with me, or are the hubs screwy?  The hubs I'm on are
"smart hubs", lets just say they aren't too bright:)

I have a soyo k7vdragon+ using 2.4.17:
eth0: VIA VT6102 Rhine-II at 0xe800, 00:50:2c:01:64:a9, IRQ 11.
eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
0021.

CC replies...
-Justin
