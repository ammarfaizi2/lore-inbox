Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276470AbRJUSCW>; Sun, 21 Oct 2001 14:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276468AbRJUSCM>; Sun, 21 Oct 2001 14:02:12 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:8364 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S276451AbRJUSB7>;
	Sun, 21 Oct 2001 14:01:59 -0400
Posted-Date: Sun, 21 Oct 2001 20:02:28 +0200
Date: Sun, 21 Oct 2001 20:02:28 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: "M. Edward Borasky" <znmeb@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: DOT call graphs of Rik and AA VMs
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBAEKLDPAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.10.10110212000050.321-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it will. As I said the dot makes too big pages. It is described
in its man page section bugs.
Did you applied the patch I posted now ? It should make it
printable.
Probably I should post print-ready version of these pages, shouldn't I ?
devik

On Sun, 21 Oct 2001, M. Edward Borasky wrote:

> I tried to import the "ps" files into Acrobat 5.0 on my Windows system and
> it cut them off to a single 8" by 10.5" page.
> 
> --
> M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
> http://www.borasky-research.net
> mailto:znmeb@borasky-research.net
> http://groups.yahoo.com/group/pdx-neuro-semantics
> http://groups.yahoo.com/group/BoraskyResearchJournal
> 
> Q: How do you tell when a pineapple is ready to eat?
> A: It picks up its knife and fork.
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Martin Devera
> > Sent: Sunday, October 21, 2001 10:49 AM
> > To: Martin J. Bligh
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: DOT call graphs of Rik and AA VMs
> >
> >
> >
> >
> > On Fri, 19 Oct 2001, Martin J. Bligh wrote:
> >
> > > These print out badly (just get about 1/4), and get the same viewing in
> > > ghostscript ... any chance you can make the postscript scale to
> > fit a page?
> > > Not sure if that's possible from DOT ... or is the method you used to
> > > generate these available?
> >
> > At http://luxik.cdi.cz/~devik/mm.htm is update. Actualy dot can't scale
> > it. You can do it yourself (several postscript lines) or try psutils.
> >
> > Given high enough demand I'll create script which will scale it
> > automatically for printer.
> > devik
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> 
> 

