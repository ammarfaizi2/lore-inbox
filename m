Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbULFDgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbULFDgp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 22:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbULFDgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 22:36:45 -0500
Received: from fmr20.intel.com ([134.134.136.19]:40660 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261465AbULFDgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 22:36:43 -0500
Subject: Re: [BKPATCH] ACPI for 2.6.10
From: Len Brown <len.brown@intel.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0412031840340.19044@student.dei.uc.pt>
References: <1101945436.8026.392.camel@d845pe>
	 <Pine.LNX.4.61.0412031840340.19044@student.dei.uc.pt>
Content-Type: text/plain
Organization: 
Message-Id: <1102304175.2312.25.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Dec 2004 22:36:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 13:46, Marcos D. Marado Torres wrote:

> If this release is equivalent with -mm's bk-acpi.patch from
> 2.6.10-rc2-mm1 to 2.6.10-rc2-mm4,
> notice that this kernels' bk-acpi patches have the bug
> described in http://lkml.org/lkml/2004/11/16/263 , so I wouldn't
> really like to
> see this pull done to 2.6.10 until the problem is solved...
> 
> If you want, I can try this patch to see if it acts like
> bk-acpi.patch, but I guess it does...

Please try 2.6.10-rc3, which includes this set of patches.

Yes, this set of patches includes most of what was in -mm, but not
everything.  Note also, that it includes some more recent patches,
including a poweroff fix, that was not in the -mm patches above.

If your system still fails I'll be very interested to figure out exactly
what we did to make it stop working.

thanks,
-Len


