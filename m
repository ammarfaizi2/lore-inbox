Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKBVRg>; Thu, 2 Nov 2000 16:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129312AbQKBVR1>; Thu, 2 Nov 2000 16:17:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129026AbQKBVRA>; Thu, 2 Nov 2000 16:17:00 -0500
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
To: Tim@Rikers.org (Tim Riker)
Date: Thu, 2 Nov 2000 21:17:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01D6D1.44BD66FE@Rikers.org> from "Tim Riker" at Nov 02, 2000 02:04:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rRk1-0001ut-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can I insure that the largest possible amount of my efforts benefit
> the community at large? Hopefully this will make it easier to move to
> C99 or any other future compiler porting project.

The asm I dont know - its a hard problem. Things like C99 initializers for 2.5
seem quite a reasonable change. There are also things like partial structure
packing with __attribute((packed)) that can be hard to port

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
