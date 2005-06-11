Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVFKP7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVFKP7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVFKP7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:59:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39940 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261630AbVFKP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:59:06 -0400
Date: Sat, 11 Jun 2005 17:59:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050611155904.GD3770@stusta.de>
References: <20050611074327.GA27785@kroah.com> <20050611102133.GA3770@stusta.de> <20050611143904.GA30612@suse.de> <20050611153656.GB3770@stusta.de> <20050611154107.GA32149@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611154107.GA32149@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 04:41:07PM +0100, Christoph Hellwig wrote:
> On Sat, Jun 11, 2005 at 05:36:56PM +0200, Adrian Bunk wrote:
> > Yes, there are many places where 2.4 and 2.6 are not source compatible 
> > for good reasons. But if the effort for maintaining compatibility 
> > between 2.4 and 2.6 in one area is as easy as keeping a header file with 
> > some dummy funtions it's worth considering.
> 
> The devfs calls for 2.4 and 2.6 are totally incompatible.
>...

OK, it seems I've missed how much devfs changed during 2.5 times...

Simply discard my emails in this thread.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

