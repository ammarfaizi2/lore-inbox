Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRHKUeI>; Sat, 11 Aug 2001 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRHKUd6>; Sat, 11 Aug 2001 16:33:58 -0400
Received: from [24.64.63.13] ([24.64.63.13]:63680 "EHLO
	smail-cal.shawcable.com") by vger.kernel.org with ESMTP
	id <S268835AbRHKUdo>; Sat, 11 Aug 2001 16:33:44 -0400
Date: Sat, 11 Aug 2001 13:32:00 -0700 (PDT)
From: Daniel Bertrand <d.bertrand@ieee.org>
Subject: Re: [Emu10k1-devel] [PATCH] emu10k1 againt kernel 2.4.8
In-Reply-To: <Pine.LNX.4.33.0108111318420.847-100000@localhost.localdomain>
X-X-Sender: <d_bertra@kilrogg>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
Cc: linux-kernel@vger.kernel.org,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>
Message-id: <Pine.LNX.4.33.0108111313450.959-100000@kilrogg>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Sat, 11 Aug 2001, Rui Sousa wrote:

> Are there any "beginner" instructions for the tools?

Not yet, I'm working on it. The documentation included for now is for
installation of the driver from CVS, anyone reading it should keep that in
mind.

> Will you be mantaining this tarball? If so we can point people
> there from "Configure.help".

The ~dbertrand/ link was a quick hack (as I don't have write access to the
rest of the website). We should setup a proper download page linked from
the front page.


>
> Rui Sousa
> > Hi,
> >
> > Here's an 'emergency' tarball of the userland tools to go with it:
> >
> > http://opensource.creative.com/~dbertrand/emu-tools-0.9.tar.gz
> >
> >
> >
> >
> > On Sat, 11 Aug 2001, Rui Sousa wrote:
> >
> > >
> > > Patch against kernel 2.4.8:
> > > 1. Fixes makefiles changes (can now be compiled as a module).
> > > 2. Reverts addition of joystick.c
> > > 3. Enables emu10k1 sequencer support.
> > > 4. Adds documentation for the driver new features.
> > >
> > > Please apply,
> > >
> > > Rui Sousa
> > >
> >
> >
>
>

-- 
Daniel Bertrand

