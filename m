Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRHQRvu>; Fri, 17 Aug 2001 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271707AbRHQRvk>; Fri, 17 Aug 2001 13:51:40 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:52214 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269391AbRHQRv2>; Fri, 17 Aug 2001 13:51:28 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 11:51:00 -0600
To: Ray Lee <ray-lk@madrabbit.org>
Cc: stelian.pop@fr.alcove.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.8-ac6] (Yet) Another Sony Vaio laptop with a broken APM...
Message-ID: <20010817115100.E17372@turbolinux.com>
Mail-Followup-To: Ray Lee <ray-lk@madrabbit.org>, stelian.pop@fr.alcove.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <998066618.31380.53.camel@orca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998066618.31380.53.camel@orca>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  09:43 -0700, Ray Lee wrote:
> Huh, so *that's* what's going on. I normally just pay attention to the
> percentage left, since the minutes display was horked. The patch against
> 2.4.8-ac6 below fixes the same problem for my PCG-XG29. (It may fix it
> for a few others as well, at least the XG29K, perhaps the XG19/19k as
> well. IIRC, they just differ in the screen size and which version of
> windows you have to blow away.)
> 
> It's looking more and more likely that they're all backwards. Hey, at
> least they're consistent, right?

Yes, I think the same is true with my PXG-XG9 (minutes being wrong),
but I haven't actually tested if the patch works.  I always assumed
it was because I have two batteries installed.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

