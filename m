Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310527AbSCGUvL>; Thu, 7 Mar 2002 15:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310533AbSCGUvB>; Thu, 7 Mar 2002 15:51:01 -0500
Received: from altus.drgw.net ([209.234.73.40]:65291 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S310527AbSCGUuo>;
	Thu, 7 Mar 2002 15:50:44 -0500
Date: Thu, 7 Mar 2002 14:50:31 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, Larry McVoy <lm@work.bitmover.com>,
        Kent Borg <kentborg@borg.org>,
        The Open Source Club at The Ohio State University 
	<opensource-admin@cis.ohio-state.edu>,
        linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307145031.V1682@altus.drgw.net>
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020305163809.D1682@altus.drgw.net> <20020305165123.V12235@work.bitmover.com> <20020306095434.B6599@borg.org> <20020306085646.F15303@work.bitmover.com> <20020306221305.GA370@elf.ucw.cz>, <20020306221305.GA370@elf.ucw.cz>; <20020307101701.S1682@altus.drgw.net> <3C87C583.C8565E4B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C87C583.C8565E4B@zip.com.au>; from akpm@zip.com.au on Thu, Mar 07, 2002 at 11:54:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 11:54:43AM -0800, Andrew Morton wrote:
> Troy Benjegerdes wrote:
> > 
> > I'd really like everyone that's bitching about BK to shut the hell up and
> > go work on some scripts to allow a maintainer to easily manage a
> > BK<->$OTHER_SCM gateway.
> 
> ie: "We broke it.  You fix it".
> 
> It's not reasonable to expect people who shall not be using bitkeeper
> to go off and perform enhancements to bitkeeper so that they can
> continue to be effective kernel developers.

No. Try:
"You're whining, here's how fix it, because I don't have time or
motivation"

Larry went to a lot of trouble to listen to what kernel developers 
wanted, and a lot of work to implement some of it. I expect same courtesy 
of everyone who is complaining.

I am not expecting any 'enhancements to bitkeeper'.. that is Larry's job. 

> If additional development around bitkeeper is needed then the onus
> is upon the bitkeeper side to do that work.  (And yes, there are
> sides now).

If Larry can make good on his 'threat' to write a read-only cvs pserver 
interface to BK, I think he's done his part. (BK -> $OTHER_SCM)

Then I'd really like to see scripts to make it easy to go from
$YOUR_FAVORITE_SCM -> patch -> BK, while keeping important metadata, like,
oh, say, comments. The patch->BK part is already done. It's up to the
other 'side' now to get changes from $YOUR_FAVORITE_SCM into BK without
either losing lots of information, or taking lots of time.

Various people have probably already done all of this. Now can someone 
bother to spend some time to find the best methods for this and integrate
it into a nice 'packaged' setup? (along with a 'HOWTO')

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
