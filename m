Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTBJRUK>; Mon, 10 Feb 2003 12:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTBJRUK>; Mon, 10 Feb 2003 12:20:10 -0500
Received: from zok.sgi.com ([204.94.215.101]:32182 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261290AbTBJRUJ>;
	Mon, 10 Feb 2003 12:20:09 -0500
Message-ID: <3E47E170.FD3BC5BC@sgi.com>
Date: Mon, 10 Feb 2003 09:29:20 -0800
From: Casey Schaufler <casey@sgi.com>
Organization: Silicon Graphics
X-Mailer: Mozilla 4.8 [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-security-module@wirex.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
References: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org> <3E471F21.4010803@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crispin Cowan wrote:
> 
> LA Walsh wrote:
> 
> >>From: Crispin Cowan
> >>
> >>LSM does have a careful design.... meeting a
> >>goal stated by Linus nearly two years ago.
> >>
> >>
> >       A security model that mediates access to security objects by
> >logging all access and blocking access if logging cannot continue is
> >unsupportable in any straight forward, efficient and/or non-kludgy, ugly
> >way.
> >
> Because Linus asked for access control support, not audit logging
> support, it is not surprising that logging models don't fit so well.
> 
> >  Some security people were banned from the kernel
> >devel. summit because their thoughts were deemed 'dangerous': fear was they
> >were too persuasive about ideas that were deemed 'ignorant' and would
> >fool those poor kernel lambs at the summit.
> >
> Internal SGI politics.

Just a gentle reminder that Ms. Walsh is not an SGI employee
and that any opinions she may express regarding the Linux
development process are her own, and may not reflect the
views or understandings of SGI or any other individuals
involved.

In particular, dragging SGI into this discussion is
inappropriate and unnecessary. SGI is currently not
active in this effort, and makes no claims regarding
it's appropriateness to any particular purpose.

Please leave SGI, in spirit and name, out of
this discussion.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 877.557.3184
