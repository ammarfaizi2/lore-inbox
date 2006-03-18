Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWCRFDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWCRFDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCRFDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:03:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44299 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751326AbWCRFDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:03:33 -0500
Date: Sat, 18 Mar 2006 06:03:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060318050331.GD9717@stusta.de>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo> <20060317172210.GP3914@stusta.de> <20060318143444.E568717@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318143444.E568717@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 02:34:44PM +1100, Nathan Scott wrote:
> On Fri, Mar 17, 2006 at 06:22:10PM +0100, Adrian Bunk wrote:
> > On Fri, Mar 10, 2006 at 11:50:20AM +1100, Nathan Scott wrote:
> > > Something like this (works OK for me)...
> > 
> > Is this 2.6.16 material?
> 
> Its been merged already.

Ups, sorry for missing this.

> cheers.
> Nathan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

