Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270570AbRHIUex>; Thu, 9 Aug 2001 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270581AbRHIUen>; Thu, 9 Aug 2001 16:34:43 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:59145
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S270570AbRHIUe3>; Thu, 9 Aug 2001 16:34:29 -0400
Date: Thu, 09 Aug 2001 16:34:11 -0400
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu,
        lvm-devel@sistina.com
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
Message-ID: <440850000.997389251@tiny>
In-Reply-To: <200108091922.f79JMuqO023781@webber.adilger.int>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, August 09, 2001 01:22:56 PM -0600 Andreas Dilger <adilger@turbolinux.com> wrote:

>
> On an "add this patch to the kernel, please" note, support for the
> write_super_lockfs() VFS method is already in ext3, so it is a good
> thing, with the above caveats.
> 

Ok, recoding with these suggestions.  I'll need an ext3 tester, please
drop me a line if you are willing ;-)

-chris

