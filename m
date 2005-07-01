Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbVGAB7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbVGAB7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 21:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVGAB7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 21:59:35 -0400
Received: from [206.246.247.150] ([206.246.247.150]:4800 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263166AbVGAB7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 21:59:32 -0400
Date: Thu, 30 Jun 2005 21:12:26 -0400
From: Ben Collins <bcollins@debian.org>
To: rbrito@ime.usp.br
Cc: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701011226.GB2067@phunnypharm.org>
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701010157.GA7877@ime.usp.br>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 10:01:57PM -0300, Rog?rio Brito wrote:
> On Jun 28 2005, Ben Collins wrote:
> > On Tue, Jun 28, 2005 at 03:12:45AM -0300, Rog?rio Brito wrote:
> > > Is there any other information that I can provide you with that would help
> > > track this?
> > 
> > Diff git2's ieee1394 directory and the SVN repo from linux1394.org if you
> > could.

Where are these patches coming from? Also, have you tried using 2.6.13-rc1
using linux1394.org's subversion tree?

> Ok, I see that this is getting to be really important now, because I think
> that Andrew forwarded some patches to Linus and now the Firewire enclosure
> doesn't seem to work with 2.6.13-rc1 anymore (it works perfectly with
> vanilla kernel 2.6.12).
> 
> The behaviour that I get with 2.6.13-rc1 is the same one that I got with
> 2.6.12-mm1 or 2.6.12-mm2. :-(
> 
> Oh, BTW, I just checked this with another drive, an iPod (2nd Generation)
> and its partition table is also not read (like what happens with the drive
> in the Firewire enclosure).
> 
> So, I guess that this is another data point that may be useful.
> 
> 
> Thank you very much for your help, Rog?rio.
> 
> -- 
> Rog?rio Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> Homepage of the algorithms package : http://algorithms.berlios.de
> Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
