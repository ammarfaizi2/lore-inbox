Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbTCLSxD>; Wed, 12 Mar 2003 13:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261895AbTCLSxD>; Wed, 12 Mar 2003 13:53:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29453 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261893AbTCLSxA>;
	Wed, 12 Mar 2003 13:53:00 -0500
Date: Wed, 12 Mar 2003 20:03:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ben Collins <bcollins@debian.org>
Cc: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312190343.GA1918@mars.ravnborg.org>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <20030312183413.GH563@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312183413.GH563@phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 01:34:13PM -0500, Ben Collins wrote:
> > 	CVS: 110,076 deltas over all files
> > 	BK:  121,891 deltas over all files
> 
> (I can recalculate this if you tell me how many of the BK ones are empty
>  merge pointers)
> 
> 90.31%
In the linux-2.5 tree there are 19300 changesets, of which there are
2705 empty changesets - 14%.
Public information that does not require a license to read.

> I wasn't far off by saying 90%. And don't tell me I can get all the
> data, when in fact, I can't.
What kind of data is actually _missing_ in the CVS repository.
Whit data I understand something usefull!

Judging based on above numbers does not make much sense to me.
How does CVS handle a cset where the same patch got applied twice,
does that count as a delta or not. Does that count as missing data?
Empty csets touching 20 files - does that count as deltas etc.
See, lots of open questions.

> Unless of course you give me an explicit
> variance from your license, I pay for a license, or I get someone else
> with BK to get me the data.
Browsing linux.bkbits.net does not require a license - or?

> What I am not ok with, is
> seeing something that I work with everyday slowly becoming engulfed in
> gray area.

Opinions vary of course. What I have seen is that the S/N ratio has
increased on lkml due to usage of BK, but...
1) Errors are fixed sooner when Linus apply patches that has errors
2) "make defconfig" can always compile on new kernel versions
3) I can follow what has been accepted in the kernel
4) i can generate patches that does not reject due to other changes
in a tee I cannot access
5) My "diff" patches get applied and credited to me
6) Valueable comments are preserved when patches are applied
7) The kernel src has become accessible in more (not less) formats
8) The changelogs posted upon release has been much more informative

So I simply do not recognize the pattern that "becoming engulfed".
I have even better access to the kernel src that I had in the past.
 Several options exist, only one of them require BK.
Now I even have access via CVS (not that I plan to use it)

As a happy BK user I get frustrated reading also this negative
stuff, and wanted to give Larry & Co a heads up.
A lot has improved after introducing BK.

But I see that whatever Bitmover does that is (by some persons)
seen as negative.

	Sam
