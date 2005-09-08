Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVIHXYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVIHXYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVIHXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:24:24 -0400
Received: from 111.84-48-17.nextgentel.com ([84.48.17.111]:61969 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965063AbVIHXYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:24:24 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <4KtRD-7Nt-13@gated-at.bofh.it>
From: s864@ii.uib.no (Ronny V. Vindenes)
Date: 09 Sep 2005 01:23:42 +0200
In-Reply-To: <4KtRD-7Nt-13@gated-at.bofh.it>
Message-ID: <m3slwfxhxd.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 
> (kernel.org propagation is slow.  There's a temp copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> 
> 
> 
> - Added Andi's x86_64 tree, as separate patches
> 
> - Added a driver for TI acx1xx cardbus wireless NICs
> 
> - Large revamp of pcmcia suspend handling
> 
> - Largeish v4l and DVB updates
> 
> - Significant parport rework
> 
> - Many tty drivers still won't compile
> 
> - Lots of framebuffer driver updates
> 
> - There are still many patches here for 2.6.14.  We're doing pretty well
>   with merging up the subsystem trees.  ia64 and CIFS are still pending. 
>   x86_64 and several of Greg's trees (especially USB) aren't merged yet.
> 

x86-64-ptrace-ia32-bp-fix.patch breaks all 32bit apps for me on Athlon64

-- 
Ronny V. Vindenes <s864@ii.uib.no>
