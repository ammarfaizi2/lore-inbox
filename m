Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283585AbRK3JoI>; Fri, 30 Nov 2001 04:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRK3Jn6>; Fri, 30 Nov 2001 04:43:58 -0500
Received: from sdsl-216-36-113-151.dsl.sea.megapath.net ([216.36.113.151]:6883
	"EHLO stomata.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S283583AbRK3Jnu>; Fri, 30 Nov 2001 04:43:50 -0500
Subject: 2.5.0-pre4 -- Unresolved symbols in ide-floppy.o:
	ide_revalidate_drive
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 01:42:27 -0800
Message-Id: <1007113347.7815.0.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


depmod: *** Unresolved symbols in /lib/modules/2.5.1-pre4/kernel/drivers/ide/ide-floppy.o
depmod: 	ide_revalidate_drive

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y

