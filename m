Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRAMTIi>; Sat, 13 Jan 2001 14:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131575AbRAMTI2>; Sat, 13 Jan 2001 14:08:28 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:39986 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S131375AbRAMTIX>;
	Sat, 13 Jan 2001 14:08:23 -0500
Date: Sat, 13 Jan 2001 20:10:33 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre6aa1 weird error
Message-ID: <Pine.LNX.4.30.0101132007540.11593-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan 13 01:58:17 iq kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.
Jan 13 01:58:17 iq kernel: probable hardware bug: restoring chip
configuration.

I get these, do not know why. MB is abit BH6, IDE controllers are the
onboard and a WinFast CMD648.

Have never seen such before (2.0.x and 2.2.x up till now).

Bug rather in SW maybe?

SaPE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
