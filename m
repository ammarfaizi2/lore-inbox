Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSHHUPh>; Thu, 8 Aug 2002 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317981AbSHHUPh>; Thu, 8 Aug 2002 16:15:37 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:62215 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317977AbSHHUPh>; Thu, 8 Aug 2002 16:15:37 -0400
Date: Thu, 8 Aug 2002 22:19:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@suse.de>
cc: Peter Samuelson <peter@cadcamlab.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
In-Reply-To: <20020808220317.A14531@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0208082216150.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002, Andi Kleen wrote:

> > > The real solution (imo) is to add !$CONFIG_FOO support to the config
> > > language.  Fortunately this is quite easy.  What do you people think?
> > > I didn't do xconfig or config-language.txt but I can if desired.
> >
> > I think it would help a lot if you first update the latter and somehow
> > describe what the negation in this context is supposed to mean.
>
> dependency is met when the symbol is not defined.
>
> What's the problem with the definition ?

Boolean is simple, what about tristate symbols? How does it modify the
input range?

bye, Roman

