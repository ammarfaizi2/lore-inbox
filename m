Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQKPQvW>; Thu, 16 Nov 2000 11:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbQKPQvN>; Thu, 16 Nov 2000 11:51:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130159AbQKPQvI>; Thu, 16 Nov 2000 11:51:08 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 16:20:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dwmw2@infradead.org (David Woodhouse),
        dhinds@valinux.com (David Hinds), torvalds@transmeta.com,
        tytso@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A14082F.2BF01D85@mandrakesoft.com> from "Jeff Garzik" at Nov 16, 2000 11:15:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wRm8-00080A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > pcmcia are not 100% binary compatible for all cases.
> 
> What cases are these?
> 
> David's been pretty good about putting 2.4.x support into pcmcia_cs
> package...

Build a tree with the kernel pcmcia cs, build the pcmcia modules from David
Hinds on the same tree. Attempt to randomly load David's driver modules from
yenta and vice versa.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
