Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265962AbRGAWHg>; Sun, 1 Jul 2001 18:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265961AbRGAWHR>; Sun, 1 Jul 2001 18:07:17 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:4842 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265959AbRGAWHO>; Sun, 1 Jul 2001 18:07:14 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Jul 2001 15:07:07 -0700
Message-Id: <200107012207.PAA01921@adam.yggdrasil.com>
To: dwmw2@redhat.com, linux-kernel@vger.kernel.org, sjhill@cotw.com
Subject: linux-2.4.6-pre8/drivers/mtd/nand/spia.c: undefined symbols
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	linux-2.4.6-pre8/drivers/mtd/nand/spia.c references four
undefined symbols, presumably intended to be #define constants,
although I am not sure what their values are supposed to be:

	IO_BASE
	FIO_BASE
	PEDR
	PEDDR

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
