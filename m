Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTLJPdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTLJPdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:33:17 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:59313 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263587AbTLJPdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:33:03 -0500
Date: Wed, 10 Dec 2003 07:32:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210153254.GC6896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andre Hedrick <andre@linux-ide.org>,
	Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
	Kendall Bennett <KendallB@scitechsoft.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 07:18:12AM -0800, Linus Torvalds wrote:
> Trust me, a federal judge couldn't care less about some very esoteric
> technical detail. I don't know who brought up inline functions, but they
> aren't what would force the GPL.

They've certainly been brought up here over and over as an example of
included work that forces the GPL.

> What has meaning for "derived work" is whether it stands on its own or
> not, and how tightly integrated it is. If something works with just one
> particular version of the kernel - or depends on things like whether the
> kernel was compiled with certain options etc - then it pretty clearly is
> very tightly integrated.

So what?  Plugins have a nasty tendency to have to be updated when the
main program is updated.  That doesn't mean that the Netscape license
is allowed to control the flash plugin license.  I think (and very
much hope) that your idea of a derived work is flawed.  Otherwise you
are helping make case law that is going to screw a lot people of over.
If you think Microsoft won't use your expanded definition of what is a
derived work, think again.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
