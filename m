Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263353AbSJFHxL>; Sun, 6 Oct 2002 03:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263354AbSJFHxL>; Sun, 6 Oct 2002 03:53:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55563 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S263353AbSJFHxK>;
	Sun, 6 Oct 2002 03:53:10 -0400
Date: Sun, 6 Oct 2002 09:58:41 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Larry McVoy <lm@work.bitmover.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021006075841.GA22117@alpha.home.local>
References: <20021005173057.J12580@work.bitmover.com> <Pine.LNX.4.44L.0210052150480.22735-100000@imladris.surriel.com> <20021005175349.B9032@work.bitmover.com> <1033866007.1247.4393.camel@phantasy> <20021005222405.C9032@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005222405.C9032@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 10:24:05PM -0700, Larry McVoy wrote:
> No, I'm saying that I could give you the technology to do that if you wanted
> to host on your server.  Bandwidth == money.  We already have a T1 line for
> the kernel, we're not buying another one.

BTW, you could save more bandwidth by compressing every data that goes out,
html diffs, changelogs, patches... You are in some ways lucky to have one site
which hosts really compressible data.

And concerning the hosting of the gnu patches, you could put them on another
port on the same physical server, and then cap the bandwidth based on the port
so that it wouldn't slow down your main activity, and still be available
without upgrading your T1.

Just a few thoughts...
Cheers,
Willy

