Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261656AbSJAOsW>; Tue, 1 Oct 2002 10:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJAOsW>; Tue, 1 Oct 2002 10:48:22 -0400
Received: from cibs9.sns.it ([192.167.206.29]:261 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261656AbSJAOsU>;
	Tue, 1 Oct 2002 10:48:20 -0400
Date: Tue, 1 Oct 2002 16:52:44 +0200 (CEST)
From: venom@sns.it
To: Alexander Viro <viro@math.psu.edu>
cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
In-Reply-To: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Logical Volume Manager is needed on Unix servers, and so it is needed
also on Linux.
If this LVM is obsoleted, then when will LVM2 be merged?
really we cannot have a 2.6 or 3.0 tree without a Volume Manager, it would
be a big fault.

Luigi

On Tue, 1 Oct 2002, Alexander Viro wrote:

> Date: Tue, 1 Oct 2002 10:15:26 -0400 (EDT)
> From: Alexander Viro <viro@math.psu.edu>
> To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
> Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
>      Linus Torvalds <torvalds@transmeta.com>
> Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
>
>
>
> On Tue, 1 Oct 2002, Joe Thornber wrote:
>
> > bk://device-mapper.bkbits.net/2.5-remove-lvm
> >
> > This large patch completely removes LVM from the 2.5 tree.  Please
> > apply.  Yes it really has spread as far as linux/list.h and
> > linux/kdev_t.h !
>
> Seconded - LVM in the tree is thoroughly dead.
>
> Speaking of which, would Intermezzo maintainers care to port the thing
> to 2.5?  If it's abandoned - at least say so ;-/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

