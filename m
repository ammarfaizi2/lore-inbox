Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUGWUAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUGWUAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUGWUAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:00:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:62348 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267963AbUGWUAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:00:34 -0400
Date: Fri, 23 Jul 2004 21:59:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: szonyi calin <caszonyi@yahoo.com>, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040723195923.GN19329@fs.tum.de>
References: <20040723081637.93875.qmail@web52903.mail.yahoo.com> <20040723122127.16468.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723122127.16468.qmail@lwn.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 06:21:27AM -0600, Jonathan Corbet wrote:
> > So now the world is divided in gods (i.e distributions) and we,
> > mere mortals who should pray to the gods to give us a stable
> >  kernel ?
> 
> This seems to be where a lot of the misunderstanding is.  Did anybody
> notice just how divergent the distributors' 2.4 (and prior) kernels were
> from the mainline?  If you wanted a kernel with that level of features
> and stability, you had to get it from them - or apply hundreds of
> patches yourself.

The 2.4.18 kernel source in Debian stable in has at about 300kB patches 
applied (gzip'ed 60kB), and many of them fix security bugs that were 
reported since 2.4.18 was released.

> One of the goals of the process now is to get those distributor patches
> into the mainline quickly.  My expectation is that the mainline kernel
> will be far closer to what the distributors ship than it has been in a
> long time, and the mainline will be more stable for it.  Just the
> opposite of what a lot of people are saying.

OTOH, distributions might have to ship more kernel versions and provide 
security updates for more kernels if features in newer 2.6 kernels break 
architectures or subarchitectures they support.

> jon

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

