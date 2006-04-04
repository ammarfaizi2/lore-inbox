Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWDDDgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWDDDgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWDDDgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:36:39 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:39345 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S964993AbWDDDgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:36:39 -0400
Date: Mon, 3 Apr 2006 20:36:33 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: blade servers?
In-Reply-To: <20060404024244.28E9A5F76B@work.bitmover.com>
Message-ID: <Pine.LNX.4.64.0604031956210.23087@twin.uoregon.edu>
References: <20060404024244.28E9A5F76B@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006, Larry McVoy wrote:

> I figured that people here would know.  If you were looking for blade
> servers and you were more interested in cost and heat generation than the
> most performance, what would you buy?  We're looking for 20 x86 cpus.
> They have to beat ASUS terminators (nice little boxes, if you haven't
> checked them out you should, about $100 + cpu + mem + disk and they are
> quiet and run on ~100watt power supplies so they don't generate a lot
> of heat).

You're  not going to find blade hardware that's cost competitive with 
barebones pc chasis on a per unit basis...

That said you over-simplifying the issue a bit. Terminator minitowers 
are 11" high so if you set them on a shelf in a rack you get 2 in 7u or 
maybe 4, if you're willing to have a cable management nightmare and a 
heat problem in the middle.

People are willing to pay a lot relatively speaking for space efficiency, 
rack hardware, sane cable cable management, and easly repalacable parts.

In general, managing costs has a lot to do with not buying what you don't 
need which in this case sounds like lots of cpu power, but in the case of 
cluster users includes cdrom drives, floppies, occasionaly harddisks etc.

> So far, the stuff at www.rackmount.com looks pretty good but they are
> (like everyone else so far as I can tell) focussed on performance.
> For all of the Unix like platforms, we'd be happy with 2Ghz Athlons (don't
> need opterons) with 256MB.  It's true that for the windows platforms we
> like 2GB because we use 1GB as a ram disk to get reasonable performance
> out of @#!! Windows.
>
> Thanks in advance,
>
> --lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

