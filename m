Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSLMCCG>; Thu, 12 Dec 2002 21:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbSLMCCG>; Thu, 12 Dec 2002 21:02:06 -0500
Received: from host145.south.iit.edu ([216.47.130.145]:19426 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S261370AbSLMCCF>;
	Thu, 12 Dec 2002 21:02:05 -0500
Date: Thu, 12 Dec 2002 20:09:44 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: procps 2.x vs. procps 3.x
Message-ID: <20021212200944.B22769@lostlogicx.com>
References: <3DF93D89.3000704@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DF93D89.3000704@ixiacom.com>; from dkegel@ixiacom.com on Thu, Dec 12, 2002 at 05:53:13PM -0800
X-Operating-System: Linux found 2.4.20-pre10-mjc1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well at Gentoo, we are kinda using both right now.  We've noticed
some querkiness with the 3.x series where TOP will miss certain
characters in output, but the 3.x series is much prettier and
feature rich than the 2.x series.  On the other hand, 2.x is 
consistently more up to date with kernel changes since RML and Riel
maintain it and are intimately familiar with current kernel
development.  

For the moment, we are on 2.x in stable and 3.x in unstable,
awaiting fixage for the minor querks of 3.x before switching up 
to 3.x for the stable.

Hope that helps,

Brandon Low
Gentoo Linux Kernel Release Manager


On Thu, 12/12/02 at 17:53:13 -0800, Dan Kegel wrote:
> Albert Cahalan wrote in message "[ANNOUNCE] procps 3.1.3":
> > This release includes user selection in top, the sysctl -e
> > option needed to support the Red Hat 8.0 boot scripts, and
> > the use of /proc/*/wchan on recent 2.5.xx kernels.
> > 
> > For those of you still upgrading from procps 2.0.xx releases,
> > you can expect:
>  > ...
> > There's a procps-feedback@lists.sf.net mailing list you can
> > use for feature requests, bug reports, and so on. Use it!
> 
> and
> 
> Robert Love wrote in message "[announce] procps 2.0.11":
> > Rik and I are pleased to announce version 2.0.11 of procps, the package
> > that contains ps, top, free, vmstat, etc.
> > 
> > Newer versions of procps are required for 2.5 kernels.
>  > ...
> > 
> > Procps discussion, bugs, and patches are welcome at:
> > 	procps-list@redhat.com
> 
> Which one should distributions use?
> Or is that a matter of taste?
> 
> - Dan
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
