Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWFIQYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWFIQYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWFIQYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:24:08 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:25493 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030280AbWFIQYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:24:06 -0400
Date: Fri, 9 Jun 2006 18:24:04 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609162403.GA26709@harddisk-recovery.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <44899D93.5030008@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44899D93.5030008@garzik.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 12:10:59PM -0400, Jeff Garzik wrote:
> Alex Tomas wrote:
> > I believe it's as stable as before until you mount with extents
> > mount option.
> 
> If it will remain a mount option, if it is never made the default 
> (either in kernel or distro level), then only 1% of users will ever use 
> the feature.  And we shouldn't merge a 1% use feature into the _main_ 
> filesystem for Linux.

Why not? That's how htree dir indexing got in, and AFAIK most distros
use it as a default.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
