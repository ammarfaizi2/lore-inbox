Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422776AbWAMSTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbWAMSTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422794AbWAMSTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:19:33 -0500
Received: from xenotime.net ([66.160.160.81]:184 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422776AbWAMSTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:19:32 -0500
Date: Fri, 13 Jan 2006 10:19:30 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Paul Jackson <pj@sgi.com>
cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, adobriyan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
In-Reply-To: <20060113101054.d62acb0d.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0601131014160.5563@shark.he.net>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru>
 <20060107154842.5832af75.akpm@osdl.org> <20060110182422.d26c5d8b.pj@sgi.com>
 <20060113141154.GL29663@stusta.de> <20060113101054.d62acb0d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Paul Jackson wrote:

> Adrian wrote:
> > This is the amout of testing I can afford.
>
> It sounds to me like you are saying that a minute of your time is
> more valuable than a minute of each of several other peoples time.
>
> The only two people I gladly accept that argument from are Linus
> and Andrew.
>
> For the rest of us, it is important to minimize the total workload
> of all us combined, not to optimize our individual output.
>
> What you don't test, several others of us get to test.  Only its often
> more work, for -each- of us, as we each have to figure out which of
> 1000 patches caused the breakage.

I don't find building cross-toolchains quite as easy as Al does,
so I download and build with these (on i386):
  http://developer.osdl.org/dev/plm/cross_compile/
as Andrew has also mentioned in the past.

Or one can submit kernel patches for builds to an OSDL
build machine which does 8 or 9 $ARCH builds.

-- 
~Randy
