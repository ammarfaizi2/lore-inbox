Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVC0SEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVC0SEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVC0SEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:04:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62131 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261268AbVC0SEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:04:20 -0500
Date: Sun, 27 Mar 2005 19:04:17 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Aaron Gyes <floam@sh.nu>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327180417.GD3815@gallifrey>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <1111913399.6297.28.camel@laptopd505.fenrus.org> <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-rc5 (i686)
X-Uptime: 18:58:24 up 9 days,  6:08,  1 user,  load average: 0.09, 0.06, 0.04
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kyle Moffett (mrmacman_g4@mac.com) wrote:

> <flame type="Binary Driver Hatred">
> NOTE: I *strongly* discourage binary drivers.  They're crap and 
> frustrate poor PowerPC users like me.

I mostly agree - there is one case where I think they *might*
be acceptable; (and I think the original poster *may* fall
into this category).

If you are making a very specialist piece of equipment; not
the type of thing you can go and plug into any old PC; but
say an entire box with some obscure piece of hardware in
that no one would want to buy as a seperate add on. I just
don't see the need to force someone to make drivers for
this type of thing public.

Of course the poster could just go and use one of the BSDs
which is probably his safest bet.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
