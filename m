Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTJYU1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTJYU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:27:46 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:52407
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262796AbTJYU1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:27:45 -0400
Subject: Re: [RFC] must fix lists
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
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
In-Reply-To: <20031023172323.A10588@osdlab.pdx.osdl.net>
References: <3F94C833.8040204@cyberone.com.au>
	 <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
	 <20031023172323.A10588@osdlab.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Sat, 25 Oct 2003 21:18:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-10-24 at 01:23, Chris Wright wrote:
> > Someone also needs to go fix all the 2.4 security holes still in 2.6
> > last time I checked - things like the execve holes and execve versus
> > proc races.
> 
> I thought these had been fixed, but I'd be happy to take a look.

I got mail from a guy at intel implying the unshare_files stuff wasnt in
2.6 yet

