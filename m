Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUJWLX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUJWLX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 07:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUJWLX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 07:23:57 -0400
Received: from scrat.hensema.net ([62.212.82.150]:15535 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S267326AbUJWLXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 07:23:55 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: The naming wars continue...
Date: Sat, 23 Oct 2004 11:23:52 +0000 (UTC)
Message-ID: <slrncnkfq8.4aq.erik@bender.home.hensema.net>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (torvalds@osdl.org) wrote:
>  Linux-2.6.10-rc1 is out there for your pleasure.
>
> I thought long and hard about the name of this release (*), since one of
> the main complaints about 2.6.9 was the apparently release naming scheme. 
>
> Should it be "-rc1"? Or "-pre1" to show it's not really considered release
> quality yet? Or should I make like a rocket scientist, and count _down_
> instead of up? Should I make names based on which day of the week the
> release happened? Questions, questions..
>
> And the fact is, I can't see the point. I'll just call it all "-rcX",
> because I (very obviously) have no clue where the cut-over-point from
> "pre" to "rc" is, or (even more painfully obviously) where it will become
> the final next release.

When you (Linus) think a release is ready to be released, call it
-rc1. If you did your job correctly, you can just sit and wait
for a few days and release the -rc1 as a new kernel.
In the real world though, some bugs may crop up, so you'd be
forced to release a rc2. Which in turn may be released unchanged
as the final kernel.

Releases prior to a release candidate can be called whatever you
like. I'd choose -preX ;-)

-- 
Erik Hensema <erik@hensema.net>
