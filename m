Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTJWVSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJWVSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:18:38 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:19123
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261797AbTJWVSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:18:37 -0400
Subject: Re: [RFC] must fix lists
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <3F94C833.8040204@cyberone.com.au>
References: <3F94C833.8040204@cyberone.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Thu, 23 Oct 2003 22:09:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-10-21 at 06:46, Nick Piggin wrote:
> The following people have their names in Documentation/must-fix.txt. Lots

Someone also needs to go fix all the 2.4 security holes still in 2.6
last time I checked - things like the execve holes and execve versus
proc races.

