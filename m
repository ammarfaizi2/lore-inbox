Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136442AbRD3Dl4>; Sun, 29 Apr 2001 23:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136443AbRD3Dlr>; Sun, 29 Apr 2001 23:41:47 -0400
Received: from web14302.mail.yahoo.com ([216.136.173.78]:52240 "HELO
	web14302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S136442AbRD3Dlf>; Sun, 29 Apr 2001 23:41:35 -0400
Message-ID: <20010430034134.76532.qmail@web14302.mail.yahoo.com>
Date: Sun, 29 Apr 2001 20:41:34 -0700 (PDT)
From: jdnfk kjhds <leeenoooks@yahoo.com>
Subject: Re: CML2 1.3.3 is available
To: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010429232312.A3775@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If only VA Linux had a gonkulator! :-O
They've issued their third earnings warning. I found
the link on http://www.theGloriousMEEPT.com .  


--- "Eric S. Raymond" <esr@thyrsus.com> wrote:
> The latest version is always available at
> http://www.tuxedo.org/~esr/cml2/
> 
> Release 1.3.3: Sun Apr 29 23:00:33 EDT 2001
> 	* Resync with 2.4.4.
> 	* Help texts merged into symbols file; the
> `helpfile' declaration
> 	  is gone.  (Text is merged in from
> Documentation/Configure.help
> 	  at CML2 installation time.)
> 	* Tweaked the appearance of inactive help buttons
> by popular demand.
> 
> My clever plan worked.  Less than three hours after
> I pronounced 1.3.1
> "stable", somebody turned in the first crash bug in
> three weeks.  Fortunately
> it was pretty trivial to fix, a loose end from one
> of my speedups.  Fixed in
> yesterday's 1.3.2.
> 
> The big news in this version is that all the help
> texts have been merged into
> the CML2 rules files.  A typical symbol declaration
> now looks like this:
> 
> GONK_5523		'Support for B5523 adaptive gonkulator'
> text
> Say Y here to compile in support for the Bollix 5523
> adaptive gonkulator.
> .
> 
> Help texts are merged into the CML2 symbols file at
> CML2 installation time.
> The `helpfile' declaration is gone.  Among other
> things, this means you no
> longer need to run CML2 inside a kernel source tree;
> you can test the scripts 
> anywhere.
> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S.
> Raymond</a>
> 
> See, when the GOVERNMENT spends money, it creates
> jobs; whereas when the money
> is left in the hands of TAXPAYERS, God only knows
> what they do with it.  Bake
> it into pies, probably.  Anything to avoid creating
> jobs.
> 	-- Dave Barry
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
