Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131773AbQLQCPM>; Sat, 16 Dec 2000 21:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131865AbQLQCOw>; Sat, 16 Dec 2000 21:14:52 -0500
Received: from main.cornernet.com ([209.98.65.1]:25355 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S131863AbQLQCOq>; Sat, 16 Dec 2000 21:14:46 -0500
Date: Sat, 16 Dec 2000 19:44:52 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tom Vier <thomassr@erols.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Dropping chars on 16550
In-Reply-To: <E147PsV-0003HP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012161944080.6348-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

absolutely, they are.

They don't follow the same archaic I/O register mechanism, either. which
is *GOOD*.

(Just take a peak at the 16C854 sometime. You'll understand exactly how
archaic it can GET.)

Chad

> > macs and sun machines use z85c30 chips, so there are some non-16550 boxes
> > out there.
>
> SGI kit also tends to use Z85Cx30 based devices. Its unfortunate the 16xx0
> series serial controllers won as the Z85Cx30 is much more flexible ;)
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
