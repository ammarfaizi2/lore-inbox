Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVGILq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVGILq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGILq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:46:27 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40137 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261190AbVGILqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:46:24 -0400
Date: Sat, 9 Jul 2005 12:46:22 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git tree] DRM fixes/cleanups tree
In-Reply-To: <20050709120947.D2175@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0507091245330.6297@skynet>
References: <Pine.LNX.4.58.0507091202460.6297@skynet>
 <20050709120947.D2175@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Can folk consider using the -p argument to diffstat to obtain the full
> path to the file from the kernels top directory please?
>
> Consider the case where you modify just a Kconfig or Makefile.  What
> use does a diffstat showing that just one Makefile or Kconfig somewhere
> in the kernel tree was modified, but not where it was?

Will do in future...

Granted in this case it should be obviously be the drm ones as I usually
stay in my own directory, but I can see your point...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

