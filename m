Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSJQRpI>; Thu, 17 Oct 2002 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSJQRpH>; Thu, 17 Oct 2002 13:45:07 -0400
Received: from [198.149.18.6] ([198.149.18.6]:42721 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262019AbSJQRpH>;
	Thu, 17 Oct 2002 13:45:07 -0400
Date: Thu, 17 Oct 2002 12:50:52 -0500
From: Robin Holt <holt@sgi.com>
X-X-Sender: <holt@fsgi123.americas.sgi.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: John Hesterberg <jh@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
In-Reply-To: <20021017162140.GA26026@suse.de>
Message-ID: <Pine.SGI.4.33.0210171249500.23137-100000@fsgi123.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 17 Oct 2002, Dave Jones wrote:

> On Thu, Oct 17, 2002 at 10:21:47AM -0500, John Hesterberg wrote:
>  > 2.5.43 versions of CSA, Job, and PAGG patches are available at:
>  >     ftp://oss.sgi.com/projects/pagg/download/linux-2.5.43-pagg-job.patch
>  >     ftp://oss.sgi.com/projects/csa/download/linux-2.5.43-csa.patch
>
> The first two lines in the csa patch contain an obvious jiffy-wrap bug.

Fixed.  The patch file named above is now a link to
linux-2.5.43_002-csa.patch.  The old file is linux-2.5.43_001-csa.patch

If you could re-review, I would appreciate it.

Thanks,
Robin Holt

