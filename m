Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVLEXZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVLEXZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVLEXZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:25:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964858AbVLEXZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:25:23 -0500
Date: Tue, 6 Dec 2005 00:25:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205232521.GP9973@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <43949541.9060700@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43949541.9060700@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 02:30:09PM -0500, Bill Davidsen wrote:
> 
> Actually I would be happy with the stability of this series if people 
> would stop trying to take working features OUT of it! That's the largest 
> problem I see, not that the existing features are unstable, and we have 
> a -stable branch to cover that, but that I can't count on features I use 
> and which are required for useful work.
> 
> If a firm policy of not removing supported features until 2.7 was 
> adopted I don't see a problem. The bulk of the instability (not 
> absolutely all, I grant), is in new features, or features which aren't 
> working all that well in any case. But if existing features suddenly 
> drop out from beneath the user, then you will find people doing what you 
> mentioned, staying with old kernels with holes rather than moving to 
> kernels which are simply no longer functional.

You are thinking in terms of the old development model.

This is not an option since the current development model says that 
there might never be a 2.7 kernel series.

We might like it or not, but this is the current development model and 
Andrew and Linus don't seem to want to change it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

