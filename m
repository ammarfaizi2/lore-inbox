Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286620AbSABBaO>; Tue, 1 Jan 2002 20:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286502AbSABBaF>; Tue, 1 Jan 2002 20:30:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10934 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286528AbSABB34>;
	Tue, 1 Jan 2002 20:29:56 -0500
Date: Tue, 1 Jan 2002 20:29:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: a great C++ book?
In-Reply-To: <a0tmmt$ear$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201012015430.16467-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 Jan 2002, H. Peter Anvin wrote:

> Personally I have found that it's quite clean and easy to program in 
> "C+" by simply using a C++ compiler and just not going wild with all
> the features that you *could* use.  You don't *have* to use all of it,
> you know.  In that way, your "M" language really becomes a particular
> *style* of C++ rather than a full-blown programming language in its
> own right.  This is actually a Good Thing[TM], since it means you can
> leverage existing compilers and so forth.

You've just described the reasons why Algol 68 is a Bad Thing(tm).  Everyone
has his own subset and almost nobody understands what exactly happens in
others' code.
 
> Way back in the 0.99.x days we actually tried doing the Linux kernel
> using the g++ compiler, the main motivation for that was to get
> type-safe linkage.  At that time, as everyone knows, g++ wasn't up to
> snuff; that has probably changed now.  The LKML FAQ claims that "there
> would be no point" unless we started using C++ features left and
> right; personally I think type-safe linkage is plenty of reason
> enough.

We can't get people to follow common style and you expect adherence to
some subset of the language smaller than "compiler doesn't spit errors
on that"?  Dream on.

And then there is "six month ago I cud not spel injuneer and now I r won"
crowd - and quite a few of them seem to be afraid of C.  FWIC it is a
damn good reason to stay with C...

