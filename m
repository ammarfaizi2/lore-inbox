Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289122AbSANWvO>; Mon, 14 Jan 2002 17:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289149AbSANWvG>; Mon, 14 Jan 2002 17:51:06 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:14727
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289122AbSANWuu>; Mon, 14 Jan 2002 17:50:50 -0500
Date: Mon, 14 Jan 2002 17:34:23 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rob Landley <landley@trommello.org>
Cc: Charles Cazabon <charlesc@discworld.dyndns.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114173423.A23081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rob Landley <landley@trommello.org>,
	Charles Cazabon <charlesc@discworld.dyndns.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <20020114125508.A3358@twoflower.internal.do> <20020114135412.D17522@thyrsus.com> <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there>; from landley@trommello.org on Mon, Jan 14, 2002 at 09:28:41AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org>:
> Make autoconfigure expands the pool of people who can build kernels,
> but it's not going to saturate the populace to the point where
> everybody immediately SHOULD.  Not even close.  Over time, the pool
> will grow.  But aiming for Aunt Tillie in the short term is probably
> overreaching.

No, it's not.  Because the second we stop thinking about Aunt Tillie,
we start making excuses for badly-designed interfaces and excessive
complexity.  We tend to fall back into insular, elitist assumptions
that limit both the useability of our software and its potential user
population.  We get lazy and stop checking our assumptions.  When we
do this, Bill Gates laughs at us, and is right to do so.

I've seen it happen in this thread.  Many lkml people clearly have the
attitude that if you aren't willing to sweat the arcana, you
shouldn't be building kernels.  Whst they don't realize is that with
that attitude, we not only lose the Aunt Tillies of the world, we
inflict a lot of unnecessary hassle on *ourselves*, too.  We're
sweating details with think time we could be spending creatively.

Therefore I try to stay focused on Aunt Tillie even though I know
that you are objectively correct and her class of user is likely
not to build kernels regularly for some years yet.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

No matter how one approaches the figures, one is forced to the rather
startling conclusion that the use of firearms in crime was very much
less when there were no controls of any sort and when anyone,
convicted criminal or lunatic, could buy any type of firearm without
restriction.  Half a century of strict controls on pistols has ended,
perversely, with a far greater use of this weapon in crime than ever
before.
        -- Colin Greenwood, in the study "Firearms Control", 1972
