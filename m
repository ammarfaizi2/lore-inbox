Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDUENR>; Sun, 21 Apr 2002 00:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSDUENQ>; Sun, 21 Apr 2002 00:13:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293603AbSDUENP>; Sun, 21 Apr 2002 00:13:15 -0400
Date: Sat, 20 Apr 2002 21:13:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Ian Molton <spyro@armlinux.org>, <linux-kernel@vger.kernel.org>
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Apr 2002, Alexander Viro wrote:
>
> "Linus documentation".

In fact, we might as well have a whole subdirectory on "Managing Linus",
which some people have become very good at.

The BK docs that people are so in a huff over really _are_ less about BK
itself, and almost entirely about how to use it to interface with me. Read
them - they are just a "SubmittingPatches" for BK, along with scripts to
automate it to get the format that I have found to be useful.

Rememebr how many times people have asked for automated tools, and for
getting notification about when I've applied a patch? You've got it. It's
all there.

Side note: remember the discussion that pushed me to _try_ BK in the first
place?

Who was it that said "Be careful what you pray for"? ;)

		Linus

