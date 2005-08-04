Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVHDUjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVHDUjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVHDUg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:36:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62990 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262645AbVHDUfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:35:01 -0400
Date: Thu, 4 Aug 2005 22:34:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mathieu Chouquet-Stringer <ml2news@optonline.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: networking problems when using gcc 4.0.1
Message-ID: <20050804203456.GC4029@stusta.de>
References: <20050731222606.GL3608@stusta.de> <200508022108.05391.gustavo@compunauta.com> <m3slxq34kf.fsf@mcs.bigip.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3slxq34kf.fsf@mcs.bigip.mine.nu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 08:53:52PM -0400, Mathieu Chouquet-Stringer wrote:
> 
> Moreover I get some weird networking problems which prevent setting up the
> routes (RNETLINK invalid argument messages) when I compile my kernel with
> 4.0.1 while the same kernel, same config works fine compiled with 3.2.3...
> 
> So eventhough 4.0 is supposed to be supported, it doesn't work too well in
> my case.

I haven't heard of such a problem.

Please give a complete bug report:
- exact error messages
- kernel version
- self-compiled gcc or distrbution compiler?

> Mathieu Chouquet-Stringer

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

