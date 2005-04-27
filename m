Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVD0RtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVD0RtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVD0Rsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:48:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:7576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261841AbVD0Rsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:48:31 -0400
Date: Wed, 27 Apr 2005 10:46:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <gregkh@suse.de>, blaisorblade@yahoo.it,
       user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [01/07] uml: add nfsd syscall when nfsd is modular
Message-ID: <20050427174652.GL23013@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com> <20050427171552.GB3195@kroah.com> <1114619612.18355.113.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114619612.18355.113.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Mer, 2005-04-27 at 18:15, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> Don't see why this one is a critical bug.

I guess without it, modular nfsd has no syscall interface (for UML, or
course).

thanks,
-chris
