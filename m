Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317795AbSFMScw>; Thu, 13 Jun 2002 14:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSFMScw>; Thu, 13 Jun 2002 14:32:52 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:43524 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317792AbSFMScu>;
	Thu, 13 Jun 2002 14:32:50 -0400
Date: Thu, 13 Jun 2002 14:23:41 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.21 : PCI DMA conversions needed
Message-ID: <Pine.LNX.4.33.0206131418530.927-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following files have been identified as requiring conversions to the 
current DMA API, as defined in Documentation/DMA-mapping.txt . If anyone 
has a conversion process, please let me know. Thanks.

Regards,
Frank

drivers/net/tlan.c
drivers/net/defxx.c
drivers/net/rrunner.c
drivers/net/rcpci45.c
drivers/scsi/inia100.c
drivers/scsi/gdth.c
drivers/scsi/53c7,8xx.c
drivers/scsi/eata_dma.c
drivers/scsi/AM53C974.c
drivers/scsi/BusLogic.c
drivers/scsi/scsiiom.c
drivers/scsi/atp870u.c
drivers/scsi/ini9100u.c
drivers/scsi/dpt_i2o.c
drivers/message/i2o/i2o_block.c
drivers/message/i2o/i2o_config.c
drivers/message/i2o/i2o_core.c
drivers/message/i2o/i2o_lan.c
drivers/message/i2o/i2o_scsi.c

