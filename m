Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313226AbSC1TXN>; Thu, 28 Mar 2002 14:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313234AbSC1TXD>; Thu, 28 Mar 2002 14:23:03 -0500
Received: from bitmover.com ([192.132.92.2]:46468 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313226AbSC1TWy>;
	Thu, 28 Mar 2002 14:22:54 -0500
Date: Thu, 28 Mar 2002 11:22:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net down
Message-ID: <20020328112252.F22352@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203271853.g2RIrRv11812@work.bitmover.com> <20020327222738.B16149@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 10:27:38PM -0800, Larry McVoy wrote:
> We did indeed lose the primary disk (IBM 40GB, I am starting to lose all
> the respect I had for IBM drives, this is one of many that has failed on
> me personally).

Leaving the drive off overnight "fixed it" enough that I am able to get
some of the data off.  It will be a couple hours before I know how much,
but I did manage to get all the ssh keys, project descriptions, and 
project statistics.  I'm now working on the actual data just in case
there is one of the trees, such as the ppc trees, that we can't find
again.

The drive has bad blocks and when it hits them it goes into retry la la land,
so I won't know which data is bad until I hit the bad blocks.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
