Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284111AbRLAO2b>; Sat, 1 Dec 2001 09:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284113AbRLAO2U>; Sat, 1 Dec 2001 09:28:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29450 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284111AbRLAO2J>; Sat, 1 Dec 2001 09:28:09 -0500
Subject: Updated AACraid driver
To: linux-kernel@vger.kernel.org, aacraid@adaptec.com,
        linux-aacraid-devel@dell.com
Date: Sat, 1 Dec 2001 14:37:01 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ABGH-0007KB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the cleaned up aacraid driver I released. Version 0.9.8 is now
on ftp://ftp.linux.org.uk/pub/linux/alan

It has
	-	SMP build fixes 		(Christoph Hellwig)
	-	Move template into C file	(Christoph Hellwig)
	-	Fix (void *) 32bit assumption	(me)
	-	Add endian conversions		(me)
	-	Use pci mapping API throughout	(me)

Alan
