Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289794AbSA2SBS>; Tue, 29 Jan 2002 13:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289793AbSA2SBI>; Tue, 29 Jan 2002 13:01:08 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:64399
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289795AbSA2SBB>; Tue, 29 Jan 2002 13:01:01 -0500
Date: Tue, 29 Jan 2002 13:00:57 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129130057.A15914@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-TReply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar:
>If a patch gets ignored 33 times in a row then perhaps the person doing
>the patch should first think really hard about the following 4 issues:
>
>  - cleanliness
>  - concept
>  - timing
>  - testing
>
>a violation of any of these items can cause patch to be dropped *without
>notice*. Face it, it's not Linus' task to teach people how to code or how
>to write correct patches. Sure, he still does teach people most of the
>time, but you cannot *expect* him to be able to do it 100% of the time.

Since the "33 times in a row" seems to refer to my bad experience with the
Configure.help patches, I think I need to correct a misconception.

The patches in question were *documentation*.  No concept issue, no
timing issue, no testing issue (I don't know what a "cleanliness"
issue would be in this context).  I know that Michael Elizabeth
Chastain, the listed CML1 maintainer, has had similar frustrating
exoeriences trying to get documentation patches folded in.

We're not talking about obscure internals changes that could break the
kernel, we're talking zero-risk patches submitted by official maintainers.  
This is not a situation that ought to require a lot of judgment or
attention on Linus's part.  

The fact that Linus *does* have to pass on all such patches, and is
dropping a lot of them them on the floor, is the clearest possible
example of the weaknesses in the present system.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
