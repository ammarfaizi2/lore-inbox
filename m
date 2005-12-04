Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVLDIbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVLDIbk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 03:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLDIbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 03:31:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30365 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750856AbVLDIbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 03:31:40 -0500
Date: Sun, 4 Dec 2005 00:31:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Simon.Derr@bull.net
Subject: Re: How do I remove a patch buried in your *-mm series?
Message-Id: <20051204003134.7c899d0f.pj@sgi.com>
In-Reply-To: <20051204001525.2889f924.akpm@osdl.org>
References: <20051203234900.fcaa6caf.pj@sgi.com>
	<20051204001525.2889f924.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
    E. You send a _minimal_ patch ... prior
       to going to Linus.

No!  This isn't (for now at least) a fix.  It's a nuke.

I don't want that "cpuset-change-marker-for-relative-numbering.patch"
going to Linus, because I am hesitating whether I even want that
"feature".

I want to nuke it now.  You might see it again, fixed up, or you
might never see it again (I doubt you'll miss it ;).  I don't
know yet.

Yes - the collisions resulting from removing this patch are easy to edit,
if that fits your style.  If you hadn't removed the useless silly
zero initializers, I would have in my next set patches.  It was on
my todo list, thanks to an earlier comment of yours.

So ... not E ;).  What's your preference now?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
