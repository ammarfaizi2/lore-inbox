Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQLCS6k>; Sun, 3 Dec 2000 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131003AbQLCS6a>; Sun, 3 Dec 2000 13:58:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44600 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129732AbQLCS6N>; Sun, 3 Dec 2000 13:58:13 -0500
Subject: Re: Phantom PS/2 mouse persists..
To: shirsch@adelphia.net (Steven N. Hirsch)
Date: Sun, 3 Dec 2000 18:27:52 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012031021580.3253-100000@pii.fast.net> from "Steven N. Hirsch" at Dec 03, 2000 10:24:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142drf-0002yf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, 2.2.18pre24 is still convinced that I have a PS/2 mouse
> attached to my machine.

I've fixed the major case. I can see no definitive answer to the other ghost
PS/2 stuff (except maybe USB interactions). I take it like the others 2.4test
also misreports a PS/2 mouse being present.

Anyway I think its no longer a showstopper for 2.2.18. Someone with an affected
board can piece together the picture

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
