Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319373AbSHQJRb>; Sat, 17 Aug 2002 05:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319374AbSHQJRb>; Sat, 17 Aug 2002 05:17:31 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:29966 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S319373AbSHQJRa>;
	Sat, 17 Aug 2002 05:17:30 -0400
Date: Sat, 17 Aug 2002 11:21:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817092124.GB3587@win.tue.nl>
References: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com> <Pine.GSO.4.21.0208162211030.14493-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208162211030.14493-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 10:32:10PM -0400, Alexander Viro wrote:

> Let me put it another way: I feel that a lot of things can be un-obfuscated
> by pure equivalent transformations that would treat almost all driver as
> block box

Yes.

(But things here are a bit more subtle than for example VFS,
since there are timing restrictions.)
