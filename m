Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQLMR3B>; Wed, 13 Dec 2000 12:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130558AbQLMR2v>; Wed, 13 Dec 2000 12:28:51 -0500
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:20320 "EHLO
	porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
	id <S129588AbQLMR2g>; Wed, 13 Dec 2000 12:28:36 -0500
Date: Wed, 13 Dec 2000 18:58:08 +0200 (EET)
From: Samuli Kaski <samkaski@cs.Helsinki.FI>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12 unresolved symbols in ide-scsi.o
Message-ID: <Pine.LNX.4.30.0012131847020.20893-100000@melkki.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't change my config and things work with test11. Sorry for the
noise if I have missed some announcement about ide-scsi.

/lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: unresolved symbol scsi_unregister_module
/lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: unresolved symbol scsi_register
/lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: unresolved symbol scsi_register_module
/lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: insmod /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o failed
/lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: insmod ide-scsi failed

	Samuli

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
