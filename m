Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbRERQGN>; Fri, 18 May 2001 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbRERQGD>; Fri, 18 May 2001 12:06:03 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:61704 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262372AbRERQGC>;
	Fri, 18 May 2001 12:06:02 -0400
Date: Fri, 18 May 2001 12:04:34 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010518120434.F14309@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Michael Meissner <meissner@spectacle-pond.org>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518105353.A13684@thyrsus.com> <E150mKO-0007FF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150mKO-0007FF-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 04:38:08PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > I don't want to do (a); it conflicts with my design objective of
> > simplifying configuration enough that Aunt Tillie can do it.  I won't 
> > do that unless I see a strong consensus that it's the only Right Thing.
> 
> Its a good way of getting the defaults right. It may also be an appropriate
> way of guiding presentation (eg putting the stuff the ruleset says you wont
> have under a subcategory so you would see
> 
> 
> 		CPU type
> 		Devices
> 		blah
> 		blah
> 		Other Options
> 			IDE disk
> 			Cardbus

I want to understand what you're driving at here and I don't get it.  What's
the referent of "Its"?  Are you saying you think Aunt Tillie's view of the
world should guide the presentation of options?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Are we at last brought to such a humiliating and debasing degradation,
that we cannot be trusted with arms for our own defence?  Where is the
difference between having our arms in our own possession and under our
own direction, and having them under the management of Congress?  If
our defence be the *real* object of having those arms, in whose hands
can they be trusted with more propriety, or equal safety to us, as in
our own hands?
        -- Patrick Henry, speech of June 9 1788
