Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbSKWQEX>; Sat, 23 Nov 2002 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSKWQEX>; Sat, 23 Nov 2002 11:04:23 -0500
Received: from host194.steeleye.com ([66.206.164.34]:35085 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266986AbSKWQEW>; Sat, 23 Nov 2002 11:04:22 -0500
Message-Id: <200211231611.gANGBQs02731@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Petr Baudis <pasky@ucw.cz>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] Updated Documentation/kernel-parameters.txt (resent, v3)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Nov 2002 10:11:26 -0600
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things like this:

+	53c7xx=		[HW,SCSI] Amiga SCSI controllers
+			See header of drivers/scsi/53c7xx.c.
+			See also drivers/scsi/README.ncr53c7xx.
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Need to change: the SCSI documentation moved to Documentation/scsi.

This readme is now called Documentation/scsi/ncr53c7xx.txt

James




