Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbQKGQQL>; Tue, 7 Nov 2000 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbQKGQQB>; Tue, 7 Nov 2000 11:16:01 -0500
Received: from [193.127.21.194] ([193.127.21.194]:39441 "HELO
	postal.sl.trymedia.com") by vger.kernel.org with SMTP
	id <S130209AbQKGQPx>; Tue, 7 Nov 2000 11:15:53 -0500
From: Abel Muñoz Alcaraz <abel@trymedia.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: A question about memory fragmentation
Date: Tue, 7 Nov 2000 17:11:45 +0100
Message-ID: <CAEBJLAGJIDLDINHENLOOENBCGAA.abel@trymedia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

	Thank you for your help!
	I am going to tell you more information.

	my question is about memory fragmentation when I allocate and free a lot of
small memory pieces in a kernel module.
	Can it do a memory fragmentation problem?
	Can I solve it using 'linux/list.h' API?

	I think that is better to allocate a big piece of memory and get the nodes
from this buffer with my own memory management functions; Is this correct?.

Thanks.

Abel Muñoz Alcaraz.
Media Security Software Developer.
mailto:abel@trymedia.com
Trymedia Systems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
