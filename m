Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129575AbQKUGEB>; Tue, 21 Nov 2000 01:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQKUGDv>; Tue, 21 Nov 2000 01:03:51 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:7179
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129575AbQKUGDe>; Tue, 21 Nov 2000 01:03:34 -0500
Date: Mon, 20 Nov 2000 21:33:24 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: ATA and Stroke Patch up
Message-ID: <Pine.LNX.4.10.10011202125440.25663-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pub/../ide-2.2.17/ide.2.2.17.all.20001120.patch
pub/../ide-2.2.18/ide.2.2.18-22.all.20001120.patch
pub/../ide.2.4.0-t11/ide.2.4.0-t11.1120.patch

If you do not set CONFIG_IDEDISK_STROKE it will warn you how much it is
keeping that you can not use.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
