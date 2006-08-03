Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWHCHUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHCHUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHCHUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48354 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932337AbWHCHUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:20:49 -0400
Date: Thu, 3 Aug 2006 00:16:22 -0700
From: Greg KH <greg@kroah.com>
To: Neil Brown <neilb@suse.de>
Cc: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>,
       akpm@osdl.org, nfs@lists.sourceforge.net, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH for stable] Re: [Fwd: moradin 2006-08-02 11:02 System Events]
Message-ID: <20060803071622.GJ26354@kroah.com>
References: <44D08371.9070607@svs.Informatik.Uni-Oldenburg.de> <17617.16700.274788.869486@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17617.16700.274788.869486@cse.unsw.edu.au>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 10:20:12AM +1000, Neil Brown wrote:
> On Wednesday August 2, pmhahn@svs.Informatik.Uni-Oldenburg.de wrote:
> > Hello!
> > 
> > Rebooting one of our NFS file servers with 2.6.17.7, I just got the
> > following OOPS:
> 
> Thanks for the report.
> The bug was fairly easy to find and fix.
> I think this would be appropriate for the next 2.6.17.x stable kernel,
> and definitely for 2.6.18. (hence 'akpm' and 'stable' cc:ed).
> 
> It is not relevant for earlier kernels (e.g. 2.6.16).
> 
> Patch was made against 2.6.18-rc2-mm1, but applies equally to
> 2.6.17.7.

Queued to -stable.

thanks,

greg k-h

