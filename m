Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbTFAWVE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264747AbTFAWVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:21:04 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:26098 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264748AbTFAWVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:21:03 -0400
Date: Sun, 1 Jun 2003 16:34:20 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: htree for 2.4 ext[23]
Message-ID: <20030601163420.D1522@schatzie.adilger.int>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030601111728.GC6067@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030601111728.GC6067@stingr.net>; from i@stingr.net on Sun, Jun 01, 2003 at 03:17:28PM +0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01, 2003  15:17 +0400, Paul P Komkoff Jr wrote:
> Anybody have working backport of these ?
> 
> Stuff available at http://thunk.org/tytso/linux/extfs-2.4-update/ IS a)
> outdated b) gives unpredictable results (e.g. eating filesystems)

Yes, we have a working set of patches for 2.4.20 and a few other kernels
in our CVS repository.  However, these are just taken from Ted's ext3 BK
repository (I don't think we changed them at all).

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-1.patch?rev=1.1.6.1&only_with_tag=b_devel
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-2.patch?rev=1.1.6.1&only_with_tag=b_devel
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-3.patch?rev=1.1.6.1&only_with_tag=b_devel
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/lustre/lustre/kernel_patches/patches/Attic/ext-2.4-patch-4.patch?rev=1.1.6.1&only_with_tag=b_devel


Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

