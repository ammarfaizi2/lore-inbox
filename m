Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264752AbSJUGlD>; Mon, 21 Oct 2002 02:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264753AbSJUGlD>; Mon, 21 Oct 2002 02:41:03 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:24050 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264752AbSJUGlD>; Mon, 21 Oct 2002 02:41:03 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 21 Oct 2002 00:43:08 -0600
To: Rob Landley <landley@trommello.org>
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, boissiere@nl.linux.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
Message-ID: <20021021064308.GA17430@clusterfs.com>
Mail-Followup-To: Rob Landley <landley@trommello.org>, karim@opersys.com,
	linux-kernel@vger.kernel.org, boissiere@nl.linux.org
References: <200210201849.23667.landley@trommello.org> <3DB398C4.6DB5CB0B@opersys.com> <200210202037.54370.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210202037.54370.landley@trommello.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2002  20:37 -0500, Rob Landley wrote:
> Ted Tso has also been posting new ext2/ext3 code with extended attributes and 
> access control lists.
> 
> Announcement:
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
> Code (chooe your poison):
> bk://extfs.bkbits.net/extfs-2.5-update 
> http://thunk.org/tytso/linux/extfs-2.5
> 
> Apparently generic ACL support went into 2.5.3 (the status list again), but I 
> guess it wasn't added to EXT2.  I suppose this makes this a good candidate 
> for inclusion then. :)
> 
> So, 11 items from the 2.5 status list (in -aa, in -mm, and "ready"), plus 
> kexec, kernelconfig, and ACL for EXT3.  I believe this brings the total 
> number of pending patchsets still hoping for 2.5 inclusion to 14.

I belive that the ext3 EA+ACL stuff is now in -mm.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

