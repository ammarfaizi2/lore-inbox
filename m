Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbVLQSiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVLQSiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVLQSiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:38:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28940 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932647AbVLQSix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:38:53 -0500
Date: Sat, 17 Dec 2005 19:38:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
Subject: Re: remove CONFIG_UID16
Message-ID: <20051217183854.GQ23349@stusta.de>
References: <20051217044410.GO23349@stusta.de> <20051217131807.GD13043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217131807.GD13043@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 01:18:07PM +0000, Christoph Hellwig wrote:
> On Sat, Dec 17, 2005 at 05:44:10AM +0100, Adrian Bunk wrote:
> > It seems noone noticed that CONFIG_UID16 was accidentially always 
> > disabled in the latest -mm kernels.
> > 
> > Is there any reason against removing it completely?
> 
> Yes, it breaks backwards-compatilbity for not even that old binaries.
> 
> There's not way we're ever going to remove it.

You are right.

Sorry, this was a dumb idea

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

