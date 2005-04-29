Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVD2EWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVD2EWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 00:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVD2EVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 00:21:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:33188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262382AbVD2EUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 00:20:50 -0400
Date: Thu, 28 Apr 2005 21:16:14 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [01/07] uml: add nfsd syscall when nfsd is modular
Message-ID: <20050429041613.GB25474@kroah.com>
References: <20050427171446.GA3195@kroah.com> <20050427171552.GB3195@kroah.com> <1114619612.18355.113.camel@localhost.localdomain> <20050427174652.GL23013@shell0.pdx.osdl.net> <1114622596.18809.120.camel@localhost.localdomain> <20050427184733.GW493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427184733.GW493@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:47:33AM -0700, Chris Wright wrote:
> * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > On Mer, 2005-04-27 at 18:46, Chris Wright wrote:
> > > > Don't see why this one is a critical bug.
> > > 
> > > I guess without it, modular nfsd has no syscall interface (for UML, or
> > > course).
> > 
> > And the trivial zero risk fix is to compile it in. Its hardly pressing
> 
> OK, let's drop it.

Dropped.

thanks,

greg k-h
