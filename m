Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271883AbRHUWuA>; Tue, 21 Aug 2001 18:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271885AbRHUWtw>; Tue, 21 Aug 2001 18:49:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271883AbRHUWtf>; Tue, 21 Aug 2001 18:49:35 -0400
Subject: Re: Qlogic/FC firmware
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Tue, 21 Aug 2001 23:52:14 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel), davem@redhat.com (David S. Miller),
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108211828150.6389-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 21, 2001 06:45:02 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZKNa-0000UE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Were's the initrd going to get the firmware?  It's not in the freakin' tree
> anymore.  If I have to go download a firmware image and stick it in an
> initrd, why the hell wouldn't I just plug it directly into the kernel?
> It's *my* kernel.

Well initrd is _user_ space so it probably gets them from user space tools.

> Oh for the love of God, will you people stop drooling over the fucking GPL?
> It's *firmware*... it's just a bunch of bits.  It's *not* a program the
> kernel executes.  It's just data. (__init_data to be exact.)

Look, if its not distributable then its no good to anyone.

> a lot of company.  Ask yourself, will you miss 128_K_ in a machine with a
> fiber channel card in it?  It "bloats" the kernel for people using that
> hardware -- machines that don't need it can release it.

Well maybe, and whats the right way to do that, oh my god I do believe its
an initrd.

Well well well

Alan
