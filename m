Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVAHSAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVAHSAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVAHSAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:00:47 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:46328 "EHLO
	mail.lysator.liu.se") by vger.kernel.org with ESMTP id S261229AbVAHSAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:00:41 -0500
From: "Jonas Svensson" <jonass@lysator.liu.se>
Organization: http://www.lysator.liu.se/
To: linux-kernel@vger.kernel.org
Date: Sat, 08 Jan 2005 19:00:34 +0100
MIME-Version: 1.0
Subject: ATA: abnormal status 0x8 on port 0xD881E31C
Reply-To: jonass@lysator.liu.se
Message-ID: <41E02DD2.30892.14CDB4FC@localhost>
X-mailer: Pegasus Mail for Windows (4.21b)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this message "ATA: abnormal status 0x8 on port 0xD881E31C", 
is that a known problem? Linux version 2.6.10-bk9 (jonas@landaree) 
(gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat Jan 8 
17:47:28 CET 2005. HW: Asus P3B-F mainboard and Promise tx2+ sata-
adapter.


Jan  8 18:27:52 landaree kernel: sata_promise PATA port found
Jan  8 18:27:52 landaree kernel: ata1: SATA max UDMA/133 cmd 0xD881E200 ctl 0xD881E238 bmdma 0x0 irq 11
Jan  8 18:27:53 landaree kernel: ata2: SATA max UDMA/133 cmd 0xD881E280 ctl 0xD881E2B8 bmdma 0x0 irq 11
Jan  8 18:27:53 landaree sshd:  succeeded
Jan  8 18:27:53 landaree kernel: ata3: PATA max UDMA/133 cmd 0xD881E300 ctl 0xD881E338 bmdma 0x0 irq 11
Jan  8 18:27:53 landaree kernel: ata1: no device found (phy stat 00000000)
Jan  8 18:27:53 landaree kernel: scsi0 : sata_promise
Jan  8 18:27:53 landaree kernel: ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
Jan  8 18:27:53 landaree kernel: ata2: dev 0 configured for UDMA/133
Jan  8 18:27:53 landaree xinetd: xinetd startup succeeded
Jan  8 18:27:53 landaree kernel: scsi1 : sata_promise
Jan  8 18:27:53 landaree kernel: ATA: abnormal status 0x8 on port 0xD881E31C
Jan  8 18:27:54 landaree kernel: ata3: disabling port
Jan  8 18:27:54 landaree kernel: scsi2 : sata_promise
/Jonas Svensson
-- 
jonass@lysator.liu.se, <http://www.lysator.liu.se/~jonass/>

