Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTKBBT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 20:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTKBBT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 20:19:28 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:31657 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S261305AbTKBBT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 20:19:27 -0500
Message-ID: <34823.68.105.173.45.1067736656.squirrel@mail.mainstreetsoftworks.com>
Date: Sat, 1 Nov 2003 20:30:56 -0500 (EST)
Subject: [PATCH 2.6.0-test9-bk6] (r8169.c) RealTek 8169 + 8110S driver patch
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

This is adapted from RealTek's latest 1.6 driver. The current
in-kernel version is marked as 1.2.  This version includes the
necessary changes to be compiled for the 2.6 kernel.  This
is the only driver known to work for the 8110S chip on many
Opteron/Athlon64 mobos.
This has been tested on UP and SMP machines.

The patch is located at:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-bk6/2.6.0-test9-bk6-r8169-8110S.patch

Linus, please apply.

-Brad House
brad_mssw@gentoo.org




