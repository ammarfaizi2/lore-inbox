Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUD1VyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUD1VyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUD1TiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:38:16 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:28934 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264941AbUD1QkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:40:13 -0400
Date: Wed, 28 Apr 2004 10:52:35 -0500
From: mikem@beardog.cca.cpqcorp.net
To: Andrew Morton <akpm@osdl.org>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Huge iowait on 2.6.4 - not on 2.4.20 !
Message-ID: <20040428155235.GD8163@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
References: <20040416142742.260dafe5.akpm@osdl.org> <20040422212429.GA8163@beardog.cca.cpqcorp.net> <20040422152138.72098369.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422152138.72098369.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an update for the MAINTAINERS file. Should have done this sooner. Sorry.

mikem
-------------------------------------------------------------------------------

diff -burpN lx266-rc2.orig/MAINTAINERS lx266-rc2/MAINTAINERS
--- lx266-rc2.orig/MAINTAINERS	2004-04-26 15:04:59.000000000 -0500
+++ lx266-rc2/MAINTAINERS	2004-04-28 10:08:30.000000000 -0500
@@ -895,21 +895,21 @@ S:	Maintained
 
 HEWLETT-PACKARD FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
 P:	Chase Maupin
-M:	Chase Maupin (support@compaq.com)
- L:	compaqandlinux@cpqlin.van-dijk.net
- S:	Supported
+M:	chase.maupin@hp.com
+L:	iss_storagedev@hp.com	
+S:	Maintained
  
 HEWLETT-PACKARD SMART2 RAID DRIVER
 P:	Francis Wiran
-M:	Francis Wiran <support@compaq.com>
- L:	compaqandlinux@cpqlin.van-dijk.net
- S:	Supported	
+M:	francis.wiran@hp.com
+L:	iss_storagedev@hp.com	
+S:	Maintained	
  
 HEWLETT-PACKARD SMART CISS RAID DRIVER 
-P:	Mike Miller, Michael Ni
-M:	Mike Miller, Michael Ni <support@compaq.com>
- L:	compaqandlinux@cpqlin.van-dijk.net
- S:	Supported 
+P:	Mike Miller
+M:	mike.miller@hp.com
+L:	iss_storagedev@hp.com	
+S:	Supported 
  
 HP100:	Driver for HP 10/100 Mbit/s Voice Grade Network Adapter Series
 P:	Jaroslav Kysela
-------------------------------------------------------------------------------
On Thu, Apr 22, 2004 at 03:21:38PM -0700, Andrew Morton wrote:
> mikem@beardog.cca.cpqcorp.net wrote:
> >
> > Sorry I didn't see this sooner. I'll work with the user.
> > 
> > If there is something that I need to see immediately please forward it to mike.miller@hp.com.
> > 
> 
> Could you please review the contact info in ./MAINTAINERS?  Last time I tried it,
> nothing happened.
