Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279627AbRJXWjO>; Wed, 24 Oct 2001 18:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279622AbRJXWjE>; Wed, 24 Oct 2001 18:39:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279627AbRJXWi6>; Wed, 24 Oct 2001 18:38:58 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 24 Oct 2001 23:45:15 +0100 (BST)
Cc: xavier.bestel@free.fr (Xavier Bestel),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <Pine.LNX.4.33.0110240953010.8278-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 24, 2001 09:55:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wWlw-0002vL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So as far as the kernel is concerned, a suspend is _always_ started by
> "the user". Of course, the whole point with computers is that many thin=
> gs
> can be automated, and "the user" may not be a human sitting at the
> machine.

How does that apply to the equivalent of an APM critical shutdown - do we
still vector that via userspace ?
