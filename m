Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWHXRXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWHXRXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWHXRXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:23:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15364 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030411AbWHXRXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:23:19 -0400
Date: Thu, 24 Aug 2006 19:23:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824172317.GP19810@stusta.de>
References: <20060824155814.GL19810@stusta.de> <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <17931.1156439907@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17931.1156439907@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:18:27PM +0100, David Howells wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
> > possible, and I really know what I'm doing" people.
> 
> It's not a speed thing so much as a space thing.

Yes, sorry, I really wanted to write "small" instead of "fast".

> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

