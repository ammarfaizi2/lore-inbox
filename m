Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287832AbSABPE4>; Wed, 2 Jan 2002 10:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287827AbSABPEq>; Wed, 2 Jan 2002 10:04:46 -0500
Received: from mail.sonytel.be ([193.74.243.200]:64153 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S287839AbSABPEa>;
	Wed, 2 Jan 2002 10:04:30 -0500
Date: Wed, 2 Jan 2002 15:59:29 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>, Benjamin LaHaise <bcrl@redhat.com>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <E16KSQt-0005zf-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0201021557360.1574-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Alan Cox wrote:
> The big exception is Configure.help which is a nightmare for patch, and the
> one file I basically always did hand merges on

Perhaps it would help if the entries in Configure.help were sorted?

It's very difficult to merge anything in that file, since in many cases the
`new' entries added by the new patch, already existed in our local tree
(speaking about m68k). Someone just wrote new explanations, and inserted them
someplace else in the file.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

