Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSGDAbn>; Wed, 3 Jul 2002 20:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSGDAbm>; Wed, 3 Jul 2002 20:31:42 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:32502 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317298AbSGDAbl>; Wed, 3 Jul 2002 20:31:41 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tommi Kyntola <kynde@ts.ray.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1: mouse clicks broken in X (atleast)
Date: Thu, 4 Jul 2002 10:30:36 +1000
User-Agent: KMail/1.4.5
References: <Pine.LNX.4.44.0204161148550.30988-100000@behemoth.ts.ray.fi>
In-Reply-To: <Pine.LNX.4.44.0204161148550.30988-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207041030.36843.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 21:42, Tommi Kyntola wrote:
> Not sure wether this has already been reported in some
> other thread or if it's a known issue, but I'm
> experienceing some really weird mouse behaviour in X
> with the 2.4.19-rc1.
>
> This is a new issue since nothing similar has not occured
> with any 19-preX or 19-preX-acX patches.
>
> With weird behaviour I mean mouse clicks dont pass through
> to wm as single clicks (apparently as occasional double clicks).
> I'm not going to look into this any further right now as I'm
> hoping that the person behind changes can sort it out even
> with this minimal information. Movement seems normal though.

Perhaps you can bother to tell us at least what kind of mouse it is? (ie USB, 
PS/2, serial).

If you were feeling particularly generous, you might venture what kernel 
configuration you are using, what architecture you are running, and what 
compiler you used, let alone the rest of the things that REPORTING-BUGS calls 
for.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
