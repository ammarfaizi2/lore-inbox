Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291414AbSBXVuI>; Sun, 24 Feb 2002 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291444AbSBXVt7>; Sun, 24 Feb 2002 16:49:59 -0500
Received: from ns.snowman.net ([63.80.4.34]:2063 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S291414AbSBXVtp>;
	Sun, 24 Feb 2002 16:49:45 -0500
Date: Sun, 24 Feb 2002 16:47:47 -0500 (EST)
From: <nick@snowman.net>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <20020224224246.C1949@ucw.cz>
Message-ID: <Pine.LNX.4.21.0202241647130.10803-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That was my understanding as well.  It woulnd't make terribly much sense
to hang a VLB off a PCI bus, and I'd expect it to be very difficult.
	Nick

On Sun, 24 Feb 2002, Vojtech Pavlik wrote:

> On Sun, Feb 24, 2002 at 06:32:09PM -0300, Rik van Riel wrote:
> > On Sun, 24 Feb 2002 nick@snowman.net wrote:
> > 
> > > None of the chipsets that supported VLB had more than one buss.  What
> > > I don't know is some idiot may have built a VLB-VLB bridge, but I
> > > doubt it.
> > 
> > There are PCI-VLB bridges.  Though it's unlikely, it may be
> > possible that there are systems with multiple such bridges
> > around... ;)
> 
> Uhh? I thought most the PCI & VLB systems had the PCI hanging off the
> VLB and not the other way around. At least those I've seen had it this
> way.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> 

