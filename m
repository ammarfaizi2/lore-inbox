Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268050AbUIBJdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268050AbUIBJdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUIBJdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:33:10 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:6867 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268050AbUIBJdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:33:07 -0400
Date: Thu, 2 Sep 2004 02:33:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040902023300.4be5d75a.pj@sgi.com>
In-Reply-To: <20040901015922.GM26072@krispykreme>
References: <m3zn4bidlx.fsf@averell.firstfloor.org>
	<20040831183655.58d784a3.pj@sgi.com>
	<20040901015922.GM26072@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:
> How does this look?

I haven't developed much of an eye yet for the compat routines - so this
looks ok to me, but such means little ;).

Hopefully someone else with a history here can take a look.  Or if you
whack me again, I might be able to examine it further.

Sorry ... thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
