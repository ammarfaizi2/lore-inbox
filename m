Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVD0Stk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVD0Stk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVD0St1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:49:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:32943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261957AbVD0SsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:48:09 -0400
Date: Wed, 27 Apr 2005 11:47:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <gregkh@suse.de>,
       blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [01/07] uml: add nfsd syscall when nfsd is modular
Message-ID: <20050427184733.GW493@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com> <20050427171552.GB3195@kroah.com> <1114619612.18355.113.camel@localhost.localdomain> <20050427174652.GL23013@shell0.pdx.osdl.net> <1114622596.18809.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114622596.18809.120.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Mer, 2005-04-27 at 18:46, Chris Wright wrote:
> > > Don't see why this one is a critical bug.
> > 
> > I guess without it, modular nfsd has no syscall interface (for UML, or
> > course).
> 
> And the trivial zero risk fix is to compile it in. Its hardly pressing

OK, let's drop it.

thanks,
-chris
