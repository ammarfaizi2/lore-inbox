Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSKUVRO>; Thu, 21 Nov 2002 16:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSKUVRO>; Thu, 21 Nov 2002 16:17:14 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:12977 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S264885AbSKUVRN>; Thu, 21 Nov 2002 16:17:13 -0500
Date: Thu, 21 Nov 2002 23:41:35 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: strange kernel message
Message-ID: <Pine.LNX.4.33.0211212338380.5481-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys

I'm getting the following "strange" message in my kernel logs. Probably
nothing serious but I would like to know what could be the cause.

/sbin/lspci
00:00.0 Host bridge: Relience Computer CNB20HE (rev 23)
00:00.1 Host bridge: Relience Computer CNB20HE (rev 01)
00:00.2 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
00:00.3 Host bridge: Relience Computer: Unknown device 0006 (rev 01)

message:
Uhhuh. NMI received for unknown reason 31.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?

Does anyone knows what is reason 31 NMI for my chipset ?

Thanks

----------------------------
Mihai RUSU

