Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261280AbRERRms>; Fri, 18 May 2001 13:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbRERRmi>; Fri, 18 May 2001 13:42:38 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:20745 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261280AbRERRmb>;
	Fri, 18 May 2001 13:42:31 -0400
Date: Fri, 18 May 2001 13:41:04 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010518134104.A16093@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Michael Meissner <meissner@spectacle-pond.org>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518120434.F14309@thyrsus.com> <E150nyl-0007Ot-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150nyl-0007Ot-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 06:23:55PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> What I am trying to say is that if you can infer probable configuration
> categories that are relevant then instead of automatically filling the other
> areas in and blocking changing them without using vi you can put the other
> options as a submenu. That guides the less expert user and also helps rather
> than hinders the expert

OK, that's useful input.  Noted.

There's a bit of a technical problem with the distinction between 
derivations (which are like macros) and question symbols (which can
be suppressed or unsuppressed depending on their visibility predicate
But perhaps I can think up a solution to that one over lunch.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You [should] not examine legislation in the light of the benefits it will
convey if properly administered, but in the light of the wrongs it
would do and the harm it would cause if improperly administered
	-- Lyndon Johnson, former President of the U.S.
