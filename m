Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbTGNSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGNSpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:45:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:40884 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270720AbTGNSmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:42:47 -0400
Date: Mon, 14 Jul 2003 13:55:27 -0500 (CDT)
From: <ajoshi@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <Pine.LNX.4.55L.0307141533330.8994@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10307141342420.28472-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Marcelo Tosatti wrote:

> 
> Ah really? I though that his changes were not merged in your 0.1.8 patch.
> 
> So can I just revert his patch and accept your instead that all of his
> stuff is in ? Whoaa, great.

Here is an xcept from ChangeLong section of the driver from the patch I
sent you:

+ *     2003-04-12      Mac PowerBook sleep fixes, Benjamin Herrenschmidt,
+ *                     0.1.8

I agree this isn't very descriptive of this other fixes and I can change
that, but a lot of his Mac changes have been merged in, but apparently
nobody has taken the time to actually look at that patch.  If there are
things that are missing then I asked him to tell me, which he has not so I
assume there are none.

> Ani, I received complains that you were not accepting patches from Ben. He
> needs that code in.

This is not true, see the above.  Also, its hard to "accept patches" from
people if you do NOT recieve any patches from them!  Ben's style is to get
the maintainers of drivers to go around and search for his personal tree
and do their own diffs from that tree, instead of him sending a patch to
the maintainer.

> > If so then please let me know, so I don't waste anymore of my time on
> > this driver and let someone else play these silly games and maintain it.
> 
> I prefer playing no silly games in the 2.4 stable series, as I've been
> trying to do so far. If you had accepted Ben's changes in the first place
> I wouldnt need to apply his patch.

I did accept most all of his changes when this patch was made (originally
I sent it May 12, which you did not merge into 2.4.21, probably because I
sent it during the RC stange, but after that you lost the patch ?).  Since
that time, I assume Ben has made some other changes, which I have not
recieved any word about.

Please don't accuse people of not accpeting patches when that is simply 
not true, as it can be easily said for you too.


