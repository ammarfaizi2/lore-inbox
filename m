Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbQKUWuG>; Tue, 21 Nov 2000 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131618AbQKUWt4>; Tue, 21 Nov 2000 17:49:56 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:22298 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130887AbQKUWtl>; Tue, 21 Nov 2000 17:49:41 -0500
Date: Wed, 22 Nov 2000 00:27:22 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: 53c400 driver
Message-ID: <Pine.LNX.4.21.0011220019220.25688-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Support for some 53c400 cards is still bad (the non-PnP), so I'll start
fixing this.

I'll be my fist kernel job, so please spare me :))

Issues :

53c400a non-PNP still lock this system hard. It starts barking about a
busy SCSI bus, and then I can fsck again.

To Alan : How hard is it to get thing beast (53c400 and family) to be SMP
safe ?? Or is it better to start over again ?


	Regards,

		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
