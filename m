Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNIYS>; Wed, 14 Feb 2001 03:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBNIYB>; Wed, 14 Feb 2001 03:24:01 -0500
Received: from Guard.PolyNet.Lviv.UA ([217.9.2.1]:19716 "HELO
	guard.polynet.lviv.ua") by vger.kernel.org with SMTP
	id <S129027AbRBNIXx>; Wed, 14 Feb 2001 03:23:53 -0500
Date: 14 Feb 2001 10:19:20 +0200
Message-ID: <118235361582.20010214101920@polynet.lviv.ua>
From: "Andriy Korud" <akorud@polynet.lviv.ua>
Reply-To: "Andriy Korud" <akorud@polynet.lviv.ua>
To: linux-kernel@vger.kernel.org
X-Mailer: The Bat! (v1.49)
X-Priority: 3 (Normal)
Subject: EEpro100 bug in 2.2.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
My setup is Intel 440GX MB with intergrated EEPro100.
When using Linux 2.2.18 the following happen: after reboot, I got:
     eepro100: cmd_wait for (0xffffff90) timedout with (0xffffff90)!
and NIC is dead.
After power cycle, first boot works fine and all following boots (without
power off) - see above. Very seldom (I've noticed this 2 times during
2 monthes) this happen during normal operation.

2.2.12 and 2.4.x runs without problem (but have other problems which
it unusable for me).

  

-- 
Best regards,
 Andriy                          mailto:akorud@polynet.lviv.ua


