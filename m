Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273623AbRIWO0Q>; Sun, 23 Sep 2001 10:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273643AbRIWO0G>; Sun, 23 Sep 2001 10:26:06 -0400
Received: from Aniela.EU.ORG ([194.102.102.235]:16645 "EHLO NS1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S273623AbRIWOZ6>;
	Sun, 23 Sep 2001 10:25:58 -0400
Date: Sun, 23 Sep 2001 16:47:02 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: <linux-kernel@vger.kernel.org>
Subject: linux 2.4.9-ac10 ifconfig problem
Message-ID: <Pine.LNX.4.33.0109231644250.757-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

After upgrading to 2.4.9-ac10 I get this message at boot time while the
system tries to  configure the ethernet card:

8139too Fast Ethernet driver 0.9.18a
PCI: Found IRQ 12 for device 00:13.0
eth0: RealTek RTL8139 Fast Ethernet at 0xc28e6000, 00:50:bf:18:ae:5b, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139B'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
task `ifconfig' exit_signal 17 in reparent_to_init


The card gets configured ok, but this message never showed up until now.



Regards,


/me

