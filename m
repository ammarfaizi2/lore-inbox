Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTG2Nfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271740AbTG2Nfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:35:40 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:6115 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271734AbTG2Ndy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:33:54 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Terje Kvernes" <terjekv@math.uio.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
Date: Tue, 29 Jul 2003 09:45:16 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGEELECDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <wxx1xwas5xu.fsf@nommo.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje,

>  as far as I can tell, 2.4.21 doesn't support it, but 2.4.22-pre8
>  mentions the chipset in drivers/ide/pci/piix.h.  try downloading
>  2.4.21 and patch it up to 2.4.22-pre8 and see if it works.  :-)

Thanks.  But, from what I'm hearing, this problem with the ICH4 is only
concerned with UDMA of IDE devices, so it doesn't sound like an O/S upgrade
will help my DMA bus master device (it's NOT an IDE device).

>> Management is chomping at the bit here.

>  you have my sympathy, for what it's worth.

lol.  Ahhh, some humor!  Thanks!

Regards,
Kathy

