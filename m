Return-Path: <linux-kernel-owner+w=401wt.eu-S932261AbXAGCbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbXAGCbm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbXAGCbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:31:42 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:43611 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbXAGCbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:31:42 -0500
Date: Sat, 6 Jan 2007 18:31:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Message-Id: <20070106183130.09d08218.randy.dunlap@oracle.com>
In-Reply-To: <20070107020010.GH19020@Ahmed>
References: <20070106131725.GB19020@Ahmed>
	<20070106094630.51aa62e8.randy.dunlap@oracle.com>
	<20070107020010.GH19020@Ahmed>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 04:00:10 +0200 Ahmed S. Darwish wrote:

> On Sat, Jan 06, 2007 at 09:46:30AM -0800, Randy Dunlap wrote:
> 
> > On Sat, 6 Jan 2007 15:17:25 +0200 Ahmed S. Darwish wrote:
> > 
> > > Hi all,
> > > I'm not able to find the DAC960 block driver maintainer. If someones knows
> > > please reply :).
> > 
> > It's orphaned.  Andrew can decide to merge this, or one of the
> > storage or block maintainers could possibly do that.
> > or it could go thru KJ, but then Andrew may still end up
> > merging it.
> 
> Should Kernel janitors then care of cleaning orphaned files ?.

Kernel janitors could do that (IMO).  It's up to you where you want
to send the patch.

> If so, I should forward it to Andrew Morton without CCing LKML again, right ?

I would expect that Andrew has seen the patch.  Anyway, you should
always send the patch to a mailing list and usually to a specific
maintainer also (like Andrew or a subsystem maintainer or the KJ
maintainer).  [except for some security-related patches]

---
~Randy
