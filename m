Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315325AbSEAHFE>; Wed, 1 May 2002 03:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315326AbSEAHFD>; Wed, 1 May 2002 03:05:03 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:28682 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315325AbSEAHFD>; Wed, 1 May 2002 03:05:03 -0400
Subject: 2.4.12 -- Unresolved symbols in fs/jfs/jfs.o:  block_flushpage
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 01 May 2002 00:02:52 -0700
Message-Id: <1020236572.16071.19.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in /lib/modules/2.5.12/kernel/fs/jfs/jfs.o
depmod:         block_flushpage

CONFIG_IDE=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y

#
# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y

CONFIG_JFS_FS=m
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y


