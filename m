Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTJZRGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTJZRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:06:13 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:42373 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263320AbTJZRGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:06:11 -0500
Message-ID: <32991.68.105.173.45.1067188625.squirrel@mail.mainstreetsoftworks.com>
Date: Sun, 26 Oct 2003 12:17:05 -0500 (EST)
Subject: nVidia nForce3 IDE patches for 2.6.0-test9
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables nForce2/3 IDE to properly work on 2.6.0-test9.
It also enables ATA 133 on those drives that support it.
This patch has been extensively tested by many people on x86_64
in Gentoo Linux, and is part of our current development-sources
kernel branch.

The patch for 2.6.0-test9 is located here:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-nforce-ideata133.patch

The original patches for the 2.4 kernel these are based off
of are located here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/0447/linux-2.4.23-pre4-nvide.patch
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/0448/linux-2.4.23-pre4-nvata133.patch

Please CC me on any replies!

-Brad House
brad_mssw@gentoo.org
Gentoo Linux


