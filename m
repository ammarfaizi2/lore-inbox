Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbUK2MEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUK2MEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUK2MEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:04:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63248 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261695AbUK2MEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:04:40 -0500
Date: Mon, 29 Nov 2004 13:04:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, axboe@suse.de, tim@cyberelk.net,
       mike.miller@hp.com, Andrew Morton <akpm@osdl.org>,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
       iss_storagedev@hp.com
Subject: Re: [2.6 patch] drivers/block/: some cleanups
Message-ID: <20041129120437.GD9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 10:12:20AM +0000, Christoph Hellwig wrote:
> On Thu, Nov 25, 2004 at 12:10:55AM +0100, Adrian Bunk wrote:
> > the patch below removes some unused code from drivers/block/, makes 
> > some needlessly global code static and does some other small cleanups.
> > 
> > Please review and comment.
> 
> Probably easier to review if split at a per-driver basis.

Sounds reasonable.

Splitted diffs follow.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

