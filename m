Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267837AbUHESce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267837AbUHESce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUHESbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:31:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44541 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267857AbUHESUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:20:46 -0400
Date: Thu, 5 Aug 2004 20:20:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error
Message-ID: <20040805182039.GN2746@fs.tum.de>
References: <20040805164936.GK2746@fs.tum.de> <200408051817.i75IHD715692@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051817.i75IHD715692@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 11:17:13AM -0700, Rick Lindsley wrote:

> This looks like it could happen if you compile without CONFIG_SMP ...
> which admittedly I have not tried since the sched-domain code was
> introduced.  Adrian, was this the situation in your case?

Yes.

> Rick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

