Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262375AbRERQfy>; Fri, 18 May 2001 12:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262376AbRERQfp>; Fri, 18 May 2001 12:35:45 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:2569 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262375AbRERQfe>;
	Fri, 18 May 2001 12:35:34 -0400
Date: Fri, 18 May 2001 12:34:13 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518123413.I14309@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518115839.E14309@thyrsus.com> <E150mhR-0007Ig-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150mhR-0007Ig-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 05:01:57PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > I think you're confusing a couple of different issues here, Alan.  Even 
> > supposing CML2 could parse CML1 rulesets, the design question about how
> > configuration *should* work (that is, what kind of user experience we 
> > want to create and who we optimize ruleset design for) wouldn't go away.
> 
> It would. Because people who like the old config would continue to use the 
> old tools

Excuse me?

Alan, it sounds very much like you just said something stupid.  This
seems sufficiently unlikely that I am shaking my head in disbelief and
fingernailing wax out of both ears (and if you think doing both those
things at once is easy try it sometime :-)).

Do you really believe that anyone is going to maintain the CML1 tools
for as long as a nanosecond after they get dropped out of the kernel tree?

Even supposing somebody were loony enough to do that, how would preserving
an old interface in amber do anything to explore new UI possibilities?

Perhaps I'm just unusually dense this morning.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Alcohol still kills more people every year than all `illegal' drugs put
together, and Prohibition only made it worse.  Oppose the War On Some Drugs!
