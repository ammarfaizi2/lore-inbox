Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVCHESH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVCHESH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVCHESH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:18:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:52708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261316AbVCHERm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:17:42 -0500
Date: Mon, 7 Mar 2005 20:16:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: paul@linuxaudiosystems.com, mpm@selenic.com, joq@io.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050307201646.512a2471.akpm@osdl.org>
In-Reply-To: <20050308035503.GA31704@infradead.org>
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308035503.GA31704@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 07, 2005 at 07:50:20PM -0800, Andrew Morton wrote:
> > 
> > So I still have the rt-lsm patch floating about, saying "merge me, merge
> > me!".  I'm not sure that the world would end were I to do so.
> > 
> > Consider this a prod in the direction of those who were pushing
> > alternatives ;)
> 
> It's still a really bad idea.

It solves a real problem and is well encapsulated.  The world won't end if
we merge it.

Still.  My point is: we're still awaiting anything better and thei is just
hanging around and hanging around.

>  You let the magic gid for oracle hugetlb
> patch go in with that reasonsing

Which continues to cause zero problems.

> now ew have relatime-lsm,

Not yet.

> next we
> $CAPABILITY for $FOO and we're headed straight to interface-hell.

"interface hell"?  Wow.

Still.  It seems to be what we deserve if all that fancy stuff we have
cannot address this very simple and very real-world problem.

