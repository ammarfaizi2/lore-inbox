Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276852AbRJHKri>; Mon, 8 Oct 2001 06:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276855AbRJHKr2>; Mon, 8 Oct 2001 06:47:28 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:57273 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S276852AbRJHKrT>; Mon, 8 Oct 2001 06:47:19 -0400
Date: Mon, 8 Oct 2001 12:47:04 +0200 (CEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Kenneth Johansson <ken@canit.se>
cc: Robert Love <rml@tech9.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <emu10k1-devel@opensource.creative.com>
Subject: Re: [BUG] emu10k1 and SMP
In-Reply-To: <3BC1D926.69D1AFED@canit.se>
Message-ID: <Pine.LNX.4.33.0110081245150.3012-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Kenneth Johansson wrote:

Which processor and chipset do you have?

Rui Sousa

> Robert Love wrote:
>
> > On Sun, 2001-10-07 at 18:23, Kenneth Johansson wrote:
> > > I have a problem with my sblive card with some program when I compile
> > > 2.4.10 and -ac8 for SMP.
> > >
> > > This happens with programs from loki and the machine stops or power down
> > > (yes an actuall power down). I'am sure this is sound related as stuff
> > > works if I don't load the emu10k1 driver and it only happens with SMP.
> >
> > Can you give a better description of the problem?
> >
> > Are you using the sblive driver from the kernel or CVS or ALSA?
> >
>
> The kernel.
>
> >
> > Does the problem go away if you recompile with CONFIG_SMP=n ?
> >
>
> Yes.
>
> >
> > What exactly happens? Oops?  Can you debug?  Reproduce?  Anything?
> >
>
> No oops . I get a power down or a hung system. I can reproduce this easy but
> I can't get any information out of the system it is really dead it dose not
> repond to anything even when hung and when it's powerd down it's kind of to
> late to do something about it then.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

