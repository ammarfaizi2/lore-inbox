Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263441AbRFKGba>; Mon, 11 Jun 2001 02:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263442AbRFKGbU>; Mon, 11 Jun 2001 02:31:20 -0400
Received: from nalserver.nal.go.jp ([202.26.95.66]:17077 "EHLO
	nalserver.nal.go.jp") by vger.kernel.org with ESMTP
	id <S263441AbRFKGbJ>; Mon, 11 Jun 2001 02:31:09 -0400
Date: Mon, 11 Jun 2001 15:30:24 +0900 (JST)
From: Aron Lentsch <lentsch@nal.go.jp>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: IRQ problems on new Toshiba Libretto
In-Reply-To: <Pine.LNX.4.21.0106102026290.2599-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0106111439510.1065-100000@triton.nal.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Linus Torvalds wrote:

> It's probably an ACPI-only system - rather uncommon,
> ...

It seems so - at least APM doesn't work, but ACPI does
- at least to so some extent.

> ... so ACPI per se won't fix the problem, but it
> would definitely be the next thing to look at.

If I understand correctly, I have to wait until someone
is taking up this task? Unfortunately I have now clue
about kernel proramming - well, in fact I am not even a
real programmer (I'm doing rocket engines and reusable
launch vehicle stuff).  Well in this case, whoever is
going to pick-up on this and reading this lines now,
please send you your patches, I would be pleased to do
some testing on the Libretto.

Question 2: Is there any possible workaround for the
moment? Can I e.g. "hardwire" IRQs, e.g. reading them
under Windows and hardcoding them? In this case, there
could be at least a kernel for the Libretto - the
hardware can not be modified anyway.

Thanks,
Aron


