Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVFWVs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVFWVs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWVsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:48:45 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:22509 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262736AbVFWVi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:38:58 -0400
Date: Thu, 23 Jun 2005 22:38:47 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, pavel@suse.cz, ak@muc.de, hch@lst.de
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial
 to appropriate file
In-Reply-To: <20050623113254.2675ffc6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0506232237040.20678@skynet>
References: <20050623142335.A5564@flint.arm.linux.org.uk> <20050623140316.GH3749@stusta.de>
 <20050623113254.2675ffc6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Actually it has been temporarily removed because it has a dependency on
> update-drm-ioctl-compatibility-to-new-world-order.patch which has a
> dependency on David's DRM tree and I don't know how to get David's DRM tree
> any more.  Hint.

I'll have a new DRM tree up in the next day or two, with it you can drop
that patch as I've folded it into my tree...

I'm still trying to get my head around the best workflow for git and me...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

