Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVACPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVACPep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVACPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:34:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35594 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261477AbVACPem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:34:42 -0500
Date: Mon, 3 Jan 2005 16:34:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103153438.GF2980@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:18:47AM -0500, Rik van Riel wrote:
> On Sun, 2 Jan 2005, Andries Brouwer wrote:
> 
> >You change some stuff. The bad mistakes are discovered very soon.
> >Some subtler things or some things that occur only in special
> >configurations or under special conditions or just with
> >very low probability may not be noticed until much later.
> 
> Some of these subtle bugs are only discovered a year
> after the distribution with some particular kernel has
> been deployed - at which point the kernel has moved on
> so far that the fix the distro does might no longer
> apply (even in concept) to the upstream kernel...
> 
> This is especially true when you are talking about really
> big database servers and bugs that take weeks or months
> to trigger.

If at this time 2.8 was already released, the 2.8 kernel available at 
this time will be roughly what 2.6 would have been under the current 
development model, and 2.6 will be a rock stable kernel.

If it was possible to get the 2.7 cycle pretty short, this would give 
the advantages of the old development model without most of its' 
disadvantages.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

