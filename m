Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282050AbRKVGtg>; Thu, 22 Nov 2001 01:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282051AbRKVGt2>; Thu, 22 Nov 2001 01:49:28 -0500
Received: from queen.bee.lk ([203.143.12.182]:56197 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S282050AbRKVGtW>;
	Thu, 22 Nov 2001 01:49:22 -0500
Date: Thu, 22 Nov 2001 12:48:08 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] enable uptime display > 497 days on 32 bit
Message-ID: <20011122124808.A3561@bee.lk>
In-Reply-To: <Pine.LNX.4.30.0111212104070.24469-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0111212104070.24469-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Wed, Nov 21, 2001 at 10:23:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 10:23:07PM +0100, Tim Schmielau wrote:
> 
> This patch makes 32 bit boxes export correct uptime to userland after
> jiffies wraparound...

Great patch!  Was wondering why no linux boxes turned up on the "longest
uptime" lists at netcraft.com.

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

Good leaders being scarce, following yourself is allowed.

