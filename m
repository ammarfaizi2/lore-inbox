Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSBMPOq>; Wed, 13 Feb 2002 10:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSBMPOh>; Wed, 13 Feb 2002 10:14:37 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:46349
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S286263AbSBMPO1>; Wed, 13 Feb 2002 10:14:27 -0500
Subject: Re: ANNOUNCEMENT: XFS patches with rmap12d + 2.4.18-pre9 +
From: Shawn Starr <spstarr@sh0n.net>
To: Roberto Rivera <rrivera@ucwphilly.rr.com>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <3C69D772.6070008@ucwphilly.rr.com>
In-Reply-To: <3C675D14.8000508@ucwphilly.rr.com>
	<1013499043.3533.1.camel@coredump>  <3C69D772.6070008@ucwphilly.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 13 Feb 2002 10:16:53 -0500
Message-Id: <1013613440.10871.8.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most appreciated. I will apply, I've been slow fixing shawn4 because I'm
in the process of merging some of my trees into a more clean structure. 

I can't use bk because it won't let me merge 2.4.17 vanilla, and SGI's
CVS tree into one with tag/branches. CVS does (sort of) so I have to
keep CVS.

For my custom branch, I have bk setup, I can just import the changes
from XFS tree as a GNU diff and merge it in.

As for rmap, I'll just keep getting the diffs from his website, since I
don't want another kernel tree to deal with :-)

Shawn.

On Tue, 2002-02-12 at 22:03, Roberto Rivera wrote:
>   Hi Shawn,
> Created an incremetal patch to shawn4 for pre7ac3 to pre9ac2, which I've 
> attached in case you were interested.
> Your shawn4 has worked great so far. I even have the preempt-O1-K3 patch 
> applied. This is the first 2.4.18pre kernel that has been able to stay 
> up all night without crashing. :) I'm going to keep my computer on to 
> see how long it will stay up before I try the new patch.
> 
> Thanks,
> Rob
> 
> Shawn Starr wrote:
> 
> >See site, new patches
> >
> >New fix coming today though -shawn5
> >
> >quota support broken compiling -- fixing today
> >
> >XFS + EXT2/EXT3 = superblock fails to be detected, another person ran
> >into this as well. unsure yet.
> >
> >Shawn.
> >
> >On Mon, 2002-02-11 at 00:56, Roberto Rivera wrote:
> >
> >>Hi Shawn,
> >>I downloaded your patches:
> >>
> >>Didn't find:
> >>  xfs-2.4.18-pre9-shawn1
> >>  containing: ac3 rmap12d and xfs
> >>
> >>Seemed to only have the xfs changes.
> >>Did I miss something?
> >>
> >>Rob
> >>


