Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132070AbQLLQsF>; Tue, 12 Dec 2000 11:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbQLLQr4>; Tue, 12 Dec 2000 11:47:56 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:64264 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S132070AbQLLQro> convert rfc822-to-8bit; Tue, 12 Dec 2000 11:47:44 -0500
Date: Tue, 12 Dec 2000 16:16:52 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Frédéric L . W . Meunier 
	<0@pervalidus.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-pci.c: typo
In-Reply-To: <20001211225133.D1245@pervalidus>
Message-ID: <Pine.LNX.4.10.10012121615090.26120-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Frédéric L . W . Meunier wrote:

> > I disagree with the patch. The bug is in printk
>
> No problem. So, it's a bug report instead. I have no clues, and just
> thought it'd be a fix :)
>
> Not sure if 2.2.17 reported the double %% from syslog. I usually look
> at my dmesg.

If it matters, I have vague recollections that the double %%
was added to prevent klogd from segfaulting.  Since everyone
has fixed their klogd's because that bug was actually (probably)
an exploitable security hole, all should be well, right?

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
