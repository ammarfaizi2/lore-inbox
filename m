Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbRERQAN>; Fri, 18 May 2001 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbRERQAD>; Fri, 18 May 2001 12:00:03 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:59400 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262370AbRERP76>;
	Fri, 18 May 2001 11:59:58 -0400
Date: Fri, 18 May 2001 11:58:39 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518115839.E14309@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <1694.990198581@ocs3.ocs-net> <E150mM9-0007Fg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150mM9-0007Fg-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 04:39:57PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > In general this is the best option, if you create a non-standard
> > configuration for machine foo then it is your problem, not everybody
> > else's.
> 
> Which makes CML2 inferior to CML1 again. Now if it could parse CML1 rulesets
> this whole discussion wouldn't be needed. 

I think you're confusing a couple of different issues here, Alan.  Even 
supposing CML2 could parse CML1 rulesets, the design question about how
configuration *should* work (that is, what kind of user experience we 
want to create and who we optimize ruleset design for) wouldn't go away.

I'm raising these questions now because CML2's capabilities invite 
thinking about them.  But they're independent of the underlying language.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To stay young requires the unceasing cultivation of the ability to
unlearn old falsehoods.
	-- Lazarus Long 
