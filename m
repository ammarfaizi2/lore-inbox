Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSHHUdT>; Thu, 8 Aug 2002 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318041AbSHHUdT>; Thu, 8 Aug 2002 16:33:19 -0400
Received: from ns.suse.de ([213.95.15.193]:51981 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318038AbSHHUdS>;
	Thu, 8 Aug 2002 16:33:18 -0400
Date: Thu, 8 Aug 2002 22:37:00 +0200
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Peter Samuelson <peter@cadcamlab.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020808223700.A22851@wotan.suse.de>
References: <20020808220317.A14531@wotan.suse.de> <Pine.LNX.4.44.0208082216150.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208082216150.28515-100000@serv>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 10:19:05PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 8 Aug 2002, Andi Kleen wrote:
> 
> > > > The real solution (imo) is to add !$CONFIG_FOO support to the config
> > > > language.  Fortunately this is quite easy.  What do you people think?
> > > > I didn't do xconfig or config-language.txt but I can if desired.
> > >
> > > I think it would help a lot if you first update the latter and somehow
> > > describe what the negation in this context is supposed to mean.
> >
> > dependency is met when the symbol is not defined.
> >
> > What's the problem with the definition ?
> 
> Boolean is simple, what about tristate symbols? How does it modify the
> input range?

It doesn't. We just want a low tech simple solution, not a great new theoretic
building.

-Andi
