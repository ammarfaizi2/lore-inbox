Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUGXSb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUGXSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUGXSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:31:29 -0400
Received: from wit.mht.bme.hu ([152.66.80.190]:55184 "EHLO wit.wit.mht.bme.hu")
	by vger.kernel.org with ESMTP id S262079AbUGXSb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:31:28 -0400
Date: Sat, 24 Jul 2004 20:31:26 +0200 (CEST)
From: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: via-velocy problem
Message-ID: <Pine.LNX.4.44.0407242015350.4553-100000@wit.wit.mht.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a via-velocity gigabit ethernet controller on my Abit KV8pro
motherboard. I tried it with kernel 2.6.7-rc1, 2.6.7-rc2 and the
2.6.7-rc1-mm1 drivermodule in 2.6.7-rc2 on A Debian SID.

If I load it at the command promt, it seems to be working without any
problem. I can set up an IP address etc.

If I load it at boot time (/etc/modules) Debian's network setup fails.

It seems to me that the problem is caused by "ifup -a". There is a screen
shot (sorry I'm lazy to type in).

http://wit.mht.bme.hu/~kubi/kernelpanic_via-velocity.jpg

How can I test the driver more precisely?

Best regards,
Kubi

