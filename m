Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130562AbQL2Dg1>; Thu, 28 Dec 2000 22:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130668AbQL2DgH>; Thu, 28 Dec 2000 22:36:07 -0500
Received: from TK152095.tuwien.teleweb.at ([195.34.152.95]:4340 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S130562AbQL2DgC>;
	Thu, 28 Dec 2000 22:36:02 -0500
Date: Fri, 29 Dec 2000 04:05:20 +0100
From: Armin Obersteiner <armin@xos.net>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx 2.4.0 test12 hang
Message-ID: <20001229040520.A3991@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

kernel: 2.4.0.test12
hardware: Adaptec AIC-7892 Ultra 160/m SCSI host adapter (19160)

problem: kernel hangs when using my cdrom with cdparanoia to read cdda data.
(i have nothing else on the bus for now.)

i'd like 2 provide more info, but after 2 *long* fsck ... (maybe tomorrow :-(

i've read about similar hangs on an alpha on this list (same kind of controller)
any solution there ...

Regards,
	Armin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
