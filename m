Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVE2PBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVE2PBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVE2PBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 11:01:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46089 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261338AbVE2PAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 11:00:54 -0400
Date: Sun, 29 May 2005 17:00:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: 2.6.12-rc5-mm1: drivers/dlm/: compile error with gcc 2.95
Message-ID: <20050529150051.GD10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org> <20050529143818.GB10441@stusta.de> <4299D52B.5080907@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4299D52B.5080907@tiscali.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 04:43:55PM +0200, Matthias-Christian Ott wrote:
> Adrian Bunk wrote:
> ><--  snip  -->
> >
> >...
> >  CC      drivers/dlm/lock.o
> >[ .. ]
> >make[2]: *** [drivers/dlm/lock.o] Error 1
> >
> ><--  snip  -->
> >
> >cu
> >Adrian
> >
> The gcc 2.95 is deprecated, so I think this is not a real problem.

Who said gcc 2.95 was deprecated? The documentation in the kernel even 
lists gcc 2.95 as the recommended compiler.

gcc 2.95 is definitely still supported, and (at least on i386) code that 
doesn't compile with gcc 2.95 is not suitable for Linus' tree.

> Matthias-Christian Ott

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

