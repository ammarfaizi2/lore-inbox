Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbTD2HhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 03:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTD2HhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 03:37:18 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:30991 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261991AbTD2HhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 03:37:18 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <0D2092D75155D511881100B0D0D00F3902D32D56@uppxmbl101.se.dell.com>
From: Martin_List-Petersen@Dell.com
To: prequejo@dbs.es, linux-kernel@vger.kernel.org
Subject: RE: LSI MegaRAID ATA driver (COMPAQ Proliant DL-320 G2)
Date: Tue, 29 Apr 2003 02:48:51 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12B0F1001514953-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I purchase a COMPAQ DL-320 G2. I've installed Redhat 7.3 with 
> a driver disk
> supplied by COMPAQ, that contains the binary of LSI MegaRAID 
> ATA controller
> driver, without problems.
> 
> Well... Now, I need to upgrade and rebuild the kernel (2.4.18 
> to 2.4.20)
> but, I haven't got the source code of the LSI MegaRAID ATA controller.
> 

Shouldn't that more or less be the same as the LSI MegaRaid SCSI driver.
Both adapters are based on the same BIOS design.

I'm pretty sure, that it should work on the default MegaRaid module (SCSI
low-level drivers).

Regards,
Martin List-Petersen

