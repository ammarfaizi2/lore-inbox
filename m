Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWADB60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWADB60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWADB60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:58:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965122AbWADB6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:58:25 -0500
Date: Tue, 3 Jan 2006 17:57:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Subject: Re: [patch 0/9] slab cleanups
Message-Id: <20060103175723.5d3c1856.akpm@osdl.org>
In-Reply-To: <1136319929.8629.15.camel@localhost>
References: <1136319929.8629.15.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
>  Here's some pending slab cleanup patches from various people. Please note
>  that the patch "slab: distinguish between object and buffer size" is a
>  replacement for the objsize renaming patch you have sitting in -mm.
> 

[ 21 out of 33 hunks FAILED -- saving rejects to file mm/slab.c.rej ]

I'd prefer to not apply any of this for now - there are plenty of slab
patches queued already and now is not the time to be churning things with
cleanups.  If you have actual functional improvements or bugfixes then
please separate those out and send.  Otherwise, please save this lot for a
few weeks hence when the current batch of stuff is merged up, thanks.
