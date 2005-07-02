Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVGBNjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVGBNjS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 09:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVGBNjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 09:39:17 -0400
Received: from [206.246.247.150] ([206.246.247.150]:43205 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261159AbVGBNjL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 09:39:11 -0400
Date: Sat, 2 Jul 2005 09:39:08 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire/SBP2 and the -mm tree (was: Re: 2.6.13-rc1-mm1)
Message-ID: <20050702133908.GB9300@phunnypharm.org>
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050702031955.GC28251@ime.usp.br>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoping that will occur this weekend.

On Sat, Jul 02, 2005 at 12:19:55AM -0300, Rog?rio Brito wrote:
> Hi, Andrew.
> 
> On Friday, 1 of July 2005 13:40, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/
> 
> Please, correct me if I am wrong, but this doesn't seem to include any
> fixes for the SBP2 problems that I was seeing, right?
> 
> I generated a patch from Linus's 2.6.13-rc1 against the trunk of
> linux1394.org's tree containing (as Ben Collins suggested), just the
> differences on sbp2.[ch] and it applied without any problems (no skips, no
> rejects, no nothing) in -rc1-mm1.
> 
> I have not tested -rc1-mm1 without the patch, but assuming that all other
> things are equal regarding it, I need this patch for using Firewire on my
> computer.
> 
> Is there any estimated possibility of including an update from the
> linux1394 team in future versions of -mm or, even better, pushing them to
> Linus's tree?
> 
> 
> Thank you very much, Rog?rio.
> 
> -- 
> Rog?rio Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> Homepage of the algorithms package : http://algorithms.berlios.de
> Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
