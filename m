Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284335AbRL1XS6>; Fri, 28 Dec 2001 18:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbRL1XSv>; Fri, 28 Dec 2001 18:18:51 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:58331
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284301AbRL1XS2>; Fri, 28 Dec 2001 18:18:28 -0500
Date: Fri, 28 Dec 2001 18:02:12 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Larry McVoy <lm@bitmover.com>, Keith Owens <kaos@ocs.com.au>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011228180212.E20254@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Larry McVoy <lm@bitmover.com>, Keith Owens <kaos@ocs.com.au>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227173739.U25698@work.bitmover.com> <18754.1009503708@ocs3.intra.ocs.com.au> <20011227174723.V25698@work.bitmover.com> <3C2CF2A8.9010406@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2CF2A8.9010406@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Dec 28, 2001 at 11:31:04PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com>:
> >>At the moment kbuild 2.5 ranges from 10% faster on small builds to 100%
> >>slower on a full kernel build.  
> >
> >I don't understand why it would be slower. 
> >
> Thank's go to basically to python and other excessfull overengineering 
> there.

Bzzzt!  Thank you for playing.

kbuild-2.5 doesn't use Python.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The possession of arms by the people is the ultimate warrant
that government governs only with the consent of the governed.
        -- Jeff Snyder
