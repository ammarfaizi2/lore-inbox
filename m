Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269844AbRHDJXP>; Sat, 4 Aug 2001 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269842AbRHDJW4>; Sat, 4 Aug 2001 05:22:56 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:5901 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S269841AbRHDJWu>; Sat, 4 Aug 2001 05:22:50 -0400
From: bvermeul@devel.blackstar.nl
Date: Sat, 4 Aug 2001 11:25:30 +0200 (CEST)
To: Jussi Laako <jlaako@pp.htv.fi>
cc: Russell King <rmk@arm.linux.org.uk>, Per Jessen <per.jessen@enidan.com>,
        <linux-kernel@vger.kernel.org>, <linux-laptop@vger.kernel.org>
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
In-Reply-To: <3B6B2DC4.B13B4B1@pp.htv.fi>
Message-ID: <Pine.LNX.4.33.0108041122520.15321-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2001, Jussi Laako wrote:

> bvermeul@devel.blackstar.nl wrote:
> >
> > Try going to your bios and setting the PCMCIA adapter to Cardbus/16bit
> > instead of Auto. The Toshiba Topic chipsets are buggy, change their PCI
>
> Dunno how to change those. The machine had just windows based setup program.

Press Esc when the laptop boots. It'll tell you you did something stupid,
and please press F1 to enter setup.

> > identifiers with different bios settings, and are just a plain pain in
> > the ass to get working. Then use the yenta driver (preferrably in
> > kernel), and I think you will find it works now. :)
>
> I wonder why it stopped working, because it was working just fine until
> lately. I don't care if it's CardBus or old ISA-based PCMCIA because it
> makes no difference as long as it works. I've been using it for years with
> Linux and FreeBSD.

Dunno why it stopped working.

> > Bas Vermeulen, who has had some bad experiences with Toshiba laptops. And
> > it's impossible to get specs for em too.
>
> Btw. is there any completely working laptop? I've got lot of problems with
> Dell and IBM laptops. I've really started to hate all this mobile stuff that
> never works...

My Dell Inspiron 8000 (Ati video chipset) works flawlessly for me. Got
everything working like it should.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

