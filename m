Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312690AbSDFSLx>; Sat, 6 Apr 2002 13:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSDFSLw>; Sat, 6 Apr 2002 13:11:52 -0500
Received: from angband.namesys.com ([212.16.7.85]:61827 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S312690AbSDFSLw>; Sat, 6 Apr 2002 13:11:52 -0500
Date: Sat, 6 Apr 2002 22:11:50 +0400
From: Oleg Drokin <green@namesys.com>
To: Larry McVoy <lm@work.bitmover.com>, Hans Reiser <reiser@namesys.com>,
        Larry McVoy <lm@bitmover.com>, reiserfs-dev@namesys.com,
        linux-kernel@vger.kernel.org, flx <flx@namesys.com>
Subject: Re: [reiserfs-dev] Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
Message-ID: <20020406221150.A9754@namesys.com>
In-Reply-To: <200204052027.g35KRc002869@bitshadow.namesys.com> <Pine.LNX.4.33.0204051347500.1746-100000@penguin.transmeta.com> <20020405171001.C6087@work.bitmover.com> <3CAEE365.4020301@namesys.com> <20020406090157.A12017@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Apr 06, 2002 at 09:01:57AM -0800, Larry McVoy wrote:
> > I am confused, the bk patches look like they have normal patches at the 
> > top of them.  
> If you just want to send him regular patches, use bk export -tpatch.
> That's sort of a lame way to go if you are using BK on both ends,
> you're going to end up merging your changes with your changes when
> you pull from Linus' tree.  There are lots of reasons why this isn't
> a good idea.

In fact, per one of the original 'BK Patches sending' HOWTO,
we are including output of bk export -tpatch ... stuff prior to
bk send ... - stuff.
So that people who want to get the diff, can get it without silly tricks.

Bye,
    Oleg
