Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTJXAYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTJXAYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:24:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:4561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261509AbTJXAXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:23:33 -0400
Date: Thu, 23 Oct 2003 17:23:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Albert Cahalan <albert@users.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] must fix lists
Message-ID: <20031023172323.A10588@osdlab.pdx.osdl.net>
References: <3F94C833.8040204@cyberone.com.au> <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 23, 2003 at 10:09:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Maw, 2003-10-21 at 06:46, Nick Piggin wrote:
> > The following people have their names in Documentation/must-fix.txt. Lots
> 
> Someone also needs to go fix all the 2.4 security holes still in 2.6
> last time I checked - things like the execve holes and execve versus
> proc races.

I thought these had been fixed, but I'd be happy to take a look.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
