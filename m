Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTLJSIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTLJSIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:08:43 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:13237 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263866AbTLJSIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:08:36 -0500
Date: Wed, 10 Dec 2003 10:08:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210180822.GI6896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
	Kendall Bennett <KendallB@scitechsoft.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com> <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com> <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 10:02:47AM -0800, Linus Torvalds wrote:
> 
> On Wed, 10 Dec 2003, Larry McVoy wrote:
> >
> > I see.  And your argument, had it prevailed 5 years ago, would have
> > invalidated the following, would it not?  The following from one of the
> > Microsoft lawsuits.
> 
> No it wouldn't.

And in the 4 minutes since I've posted that legal doc you have consulted
a lawyer and the lawyer told you this, right?

> Microsoft very much _has_ a binary API to their drivers, in a way that
> Linux doesn't.

Technicality.  Which, by your own reasoning, doesn't count.  Linux does
indeed have a binary interface, many people download drivers from some
website (I've done it a pile of times) and stuck them in and they worked.
I did that with the modem on my thinkpad across more than 10 kernel
versions in the 2.2 or 2.4 timeframe.

> So there is no analogy to the Linux case. In Linux, no fixed binary API
> exists, and the way normal drivers are distributed are as GPL'd source
> code.

Nonsense.  More distribution happens through ISO images than anything else
and the ISO images people download don't contain the source.  They *could*
download the source ones but they don't.  They download the binary image,
burn it, and install it.  And pass it around.  

If the *only* way you could get Linux was in source form and you had to 
build your own kernel, then you'd have an argument.  But that's not true
and there are plenty of examples of drivers being available for download
for Linux in binary form.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
