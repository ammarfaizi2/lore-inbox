Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbULCUio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbULCUio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbULCUio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:38:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31401 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262221AbULCUik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:38:40 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] correct copyright in arch/ia64/kernel/domain.c
Date: Fri, 3 Dec 2004 12:38:29 -0800
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
References: <200410190533.i9J5XA922671@mail.osdl.org> <Pine.LNX.4.58.0410191507290.2317@ppc970.osdl.org> <4175AB46.7010003@yahoo.com.au>
In-Reply-To: <4175AB46.7010003@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F7MsBkbikeqIcwq"
Message-Id: <200412031238.29741.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_F7MsBkbikeqIcwq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, October 19, 2004 5:03 pm, Nick Piggin wrote:
> Linus Torvalds wrote:
> > On Tue, 19 Oct 2004, Jesse Barnes wrote:
> >>On Monday, October 18, 2004 10:31 pm, akpm@osdl.org wrote:
> >>>+ * arch/ia64/kernel/domain.c
> >>>+ * Architecture specific sched-domains builder.
> >>>+ *
> >>>+ * Copyright (C) 2004  Linus Torvalds
> >>
> >>Does Linus really have the copyright on this file?
> >
> > Probably not. I've had nothing to do with the scheduler domains. I
> > suspect my name just got copied from whatever source file was used as a
> > template.
> >
> > And I don't even know which one that was ;)
> >
> > Likely kernel/sched.c. I think it's all from Nick's patches.
>
> Yep that's right :P
>
> >>  Copyright (C) 2004 Jesse Barnes <jbarnes@virtuousgeek.org>
> >>  Copyright (C) 2004 Silicon Graphics, Inc.
> >>    Jesse Barnes <jbarnes@sgi.com>
> >
> > Agreed.
>
> No problem.

Ok, here you go (finally).  A patch to correct the copyright in 
arch/ia64/kernel/domain.c.  Both Silicon Graphics, Inc. and myself (yes 
personally) hold the copyright on this file.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_F7MsBkbikeqIcwq
Content-Type: text/plain;
  charset="iso-8859-1";
  name="domain-copyright-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="domain-copyright-fix.patch"

===== arch/ia64/kernel/domain.c 1.4 vs edited =====
--- 1.4/arch/ia64/kernel/domain.c	2004-10-20 11:20:36 -07:00
+++ edited/arch/ia64/kernel/domain.c	2004-12-03 12:36:37 -08:00
@@ -2,7 +2,8 @@
  * arch/ia64/kernel/domain.c
  * Architecture specific sched-domains builder.
  *
- * Copyright (C) 2004  Linus Torvalds
+ * Copyright (C) 2004 Jesse Barnes
+ * Copyright (C) 2004 Silicon Graphics, Inc.
  */
 
 #include <linux/sched.h>

--Boundary-00=_F7MsBkbikeqIcwq--
