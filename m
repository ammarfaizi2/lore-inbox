Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131192AbQKRUxb>; Sat, 18 Nov 2000 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131272AbQKRUxU>; Sat, 18 Nov 2000 15:53:20 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25096
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131192AbQKRUxL>; Sat, 18 Nov 2000 15:53:11 -0500
Date: Sat, 18 Nov 2000 12:23:05 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: ATA/IDE: dmaproc error 14 testers wanted!
Message-ID: <Pine.LNX.4.10.10011181220390.17557-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If anyone is suffering from the dreaded "dmaproc error 14: unsupported"
error and want to test a code that could get you out of that deadlock
please speak up.

Basically this is an Intel 440BX PIIX4 issues, but the solution is global
and should work for all cases.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
