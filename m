Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129919AbQJ0Uq7>; Fri, 27 Oct 2000 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbQJ0Uqt>; Fri, 27 Oct 2000 16:46:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55410 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130346AbQJ0Uqb>; Fri, 27 Oct 2000 16:46:31 -0400
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 27 Oct 2000 21:46:47 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        andrewm@uow.edu.au (Andrew Morton),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20001027194513.A1060@bug.ucw.cz> from "Pavel Machek" at Oct 27, 2000 07:45:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pGOo-0004oy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
> reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).

There has only been one know egcs 1.1 build problem found in the last 9 
months or so (the fpu emu one). I really dont think using egcs 1.1.2 to build
2.2 kernels is a problem. In fact its probably the default nowdays

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
