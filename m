Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277178AbRJHWKP>; Mon, 8 Oct 2001 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277181AbRJHWKG>; Mon, 8 Oct 2001 18:10:06 -0400
Received: from mailf.telia.com ([194.22.194.25]:17860 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S277178AbRJHWJx>;
	Mon, 8 Oct 2001 18:09:53 -0400
Message-ID: <3BC2243C.2512BFCB@canit.se>
Date: Tue, 09 Oct 2001 00:10:04 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rui Sousa <rui.p.m.sousa@clix.pt>
CC: Robert Love <rml@tech9.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        emu10k1-devel@opensource.creative.com
Subject: Re: [BUG] emu10k1 and SMP
In-Reply-To: <Pine.LNX.4.33.0110081245150.3012-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model  : 8
model name : Pentium III (Coppermine)
stepping : 3
cpu MHz  : 701.604
cache size : 256 KB


Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 196).

Rui Sousa wrote:

> On Mon, 8 Oct 2001, Kenneth Johansson wrote:
>
> Which processor and chipset do you have?
>
> Rui Sousa
>
> > Robert Love wrote:
> >
> > > On Sun, 2001-10-07 at 18:23, Kenneth Johansson wrote:
> > > > I have a problem with my sblive card with some program when I compile
> > > > 2.4.10 and -ac8 for SMP.
> > > >
> > > > This happens with programs from loki and the machine stops or power down
> > > > (yes an actuall power down). I'am sure this is sound related as stuff
> > > > works if I don't load the emu10k1 driver and it only happens with SMP.
> > >
> > > Can you give a better description of the problem?
> > >
> > > Are you using the sblive driver from the kernel or CVS or ALSA?
> > >
> >
> > The kernel.
> >
> > >
> > > Does the problem go away if you recompile with CONFIG_SMP=n ?
> > >
> >
> > Yes.
> >
> > >
> > > What exactly happens? Oops?  Can you debug?  Reproduce?  Anything?
> > >
> >
> > No oops . I get a power down or a hung system. I can reproduce this easy but
> > I can't get any information out of the system it is really dead it dose not
> > repond to anything even when hung and when it's powerd down it's kind of to
> > late to do something about it then.
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >

