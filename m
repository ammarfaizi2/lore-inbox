Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287703AbSAABq5>; Mon, 31 Dec 2001 20:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287708AbSAABqr>; Mon, 31 Dec 2001 20:46:47 -0500
Received: from ns.suse.de ([213.95.15.193]:5124 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287703AbSAABql>;
	Mon, 31 Dec 2001 20:46:41 -0500
Date: Tue, 1 Jan 2002 02:46:37 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking 
In-Reply-To: <200201010132.g011W5TS001771@sleipnir.valparaiso.cl>
Message-ID: <Pine.LNX.4.33.0201010241400.17274-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Horst von Brand wrote:

> Hummm... I guess this is because yoiu see new (development, pre, ...)
> kernels each few days. Alan said he gets mosly line shifts (==
> non-overlapping patches, or "people should be talking to each other").
> Maybe due to the rapid version turnover? Maybe most of the merging is being
> done by the posters themselves during development, as Ye Kernel Gods refuse
> to do it for them?

In -dj, I've found a few things that I've merged haven't applied cleanly,
and in retrospect I'm glad. Because by looking at why they didn't apply,
and by fixing things up by hand, I've gained better understanding over
what I'm actually applying. This certainly makes it easier with merging
with Linus when I can explain to him what a certain change does rather
than send him a resync patch with "Some VM voodoo or other"

I've learned quite a bit in the last few weeks in areas of the kernel
I hadn't thought of looking at before now. It's certainly a
mind-broadening thing to look after something like this.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

