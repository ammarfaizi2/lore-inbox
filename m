Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131751AbQKAWwu>; Wed, 1 Nov 2000 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131774AbQKAWwk>; Wed, 1 Nov 2000 17:52:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54052 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131772AbQKAWwY>; Wed, 1 Nov 2000 17:52:24 -0500
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
To: jamagallon@able.es (J . A . Magallon)
Date: Wed, 1 Nov 2000 22:53:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20001101234058.B1598@werewolf.able.es> from "J . A . Magallon" at Nov 01, 2000 11:40:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13r6lL-0000w4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have noticed that in latest patch for 2.4.0, the global Makefile
> no more tries to find a kgcc, and falls back to gcc.
> I suppose because 2.7.2.3 is no more good for kernel, but still you
> can use 2.91, 2.95.2 or 2.96(??). Is that a patch that leaked in
> the way to test10, or is for another reason ?.

I've not yet submitted it to Linus is the obvious reason 8)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
