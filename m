Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUHEUUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUHEUUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHEUUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:20:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27897 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267828AbUHEUU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:20:27 -0400
Date: Thu, 5 Aug 2004 22:20:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error
Message-ID: <20040805202016.GP2746@fs.tum.de>
References: <20040805182039.GN2746@fs.tum.de> <200408051915.i75JFN616956@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051915.i75JFN616956@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 12:15:23PM -0700, Rick Lindsley wrote:
>     > This looks like it could happen if you compile without CONFIG_SMP ...
>     > which admittedly I have not tried since the sched-domain code was
>     > introduced.  Adrian, was this the situation in your case?
>     
>     Yes.
> 
> Ok.  Please try this patch (applied to rc3-mm1).

Thanks, it fixes compilation for me.

> Rick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

