Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbVKSCxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbVKSCxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161230AbVKSCxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:53:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161227AbVKSCxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:53:34 -0500
Date: Fri, 18 Nov 2005 18:52:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       manfred@colorfullife.com
Subject: Re: [PATCH 5/5] slab: fix code formatting
Message-Id: <20051118185249.1c0be396.akpm@osdl.org>
In-Reply-To: <iq5upx.mfs45p.e0u0z2lxcapeynwcg6471p8z4.beaver@cs.helsinki.fi>
References: <iq5ups.cbvcqc.2og64wsnmfcmozvr6ubchx30k.beaver@cs.helsinki.fi>
	<iq5upx.mfs45p.e0u0z2lxcapeynwcg6471p8z4.beaver@cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> The slab allocator code is inconsistent in coding style and messy. For this
>  patch, I ran Lindent for mm/slab.c and fixed up goofs by hand.
> 
> ...
> 
>   slab.c | 1089 ++++++++++++++++++++++++++++++++++-------------------------------
>   1 file changed, 571 insertions(+), 518 deletions(-)

Heh.  We've been patching slab.c at over one patch per week for six months.
Chances are I'll drop this one like a hot potato when something else comes
along.  We'll see.

Yes, one does need to fix up Lindent's leftovers by hand - I'll take a look
too.

And yes, slab.c is rather hard on the eyes.
