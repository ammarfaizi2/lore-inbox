Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTD2IHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 04:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTD2IHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 04:07:23 -0400
Received: from [80.81.103.97] ([80.81.103.97]:19976 "HELO ndn.net")
	by vger.kernel.org with SMTP id S261258AbTD2IHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 04:07:21 -0400
From: "Pedro Requejo" <prequejo@dbs.es>
To: <Martin_List-Petersen@Dell.com>, <linux-kernel@vger.kernel.org>
Subject: RE: LSI MegaRAID ATA driver (COMPAQ Proliant DL-320 G2)
Date: Tue, 29 Apr 2003 10:22:08 +0200
Message-ID: <PFEHLKMHNEJMMMJGBGLMGEGFCDAA.prequejo@dbs.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <0D2092D75155D511881100B0D0D00F3902D32D56@uppxmbl101.se.dell.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm just try to boot a kernel with a default AMI MegaRaid support (SCSI
low-level driver), but cannot mount the root filesystem :-(

This controller is very newer than AMI MegaRaid. By default, any kernel
can't recognize this controller. Need a patch. :-(

¿Does anybody have a COMPAQ Proliant DL-320 G2 or ML-310 or ML-330 ATA
version with linux running???

Thanks.

-----Mensaje original-----
De: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]En nombre de
Martin_List-Petersen@Dell.com
Enviado el: martes, 29 de abril de 2003 9:49
Para: prequejo@dbs.es; linux-kernel@vger.kernel.org
Asunto: RE: LSI MegaRAID ATA driver (COMPAQ Proliant DL-320 G2)


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



