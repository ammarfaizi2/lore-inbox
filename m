Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264871AbRFTKEx>; Wed, 20 Jun 2001 06:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbRFTKEn>; Wed, 20 Jun 2001 06:04:43 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:50353 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S264871AbRFTKEd>; Wed, 20 Jun 2001 06:04:33 -0400
Date: Wed, 20 Jun 2001 20:21:30 +1000
From: john slee <indigoid@higherplane.net>
To: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010620202130.H30872@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010619200442.E30785@work.bitmover.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 08:04:42PM -0700, Larry McVoy wrote:

[ ... ]

> I asked Linus for this a long time ago and he pointed out that you couldn't
> make it work over NFS, at least not nicely.  It does seem like that could
> be worked around by having a "poll daemon" which knew about all the things
> being waited on and checked them.  Or something.

could sgi's imon+fam work help a little here (with the "poll daemon" part)?
am i on the wrong train ? :-]

not sure how maintained it is these days...

[ ... ]

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
