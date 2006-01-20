Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWATIpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWATIpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWATIpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:45:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750743AbWATIpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:45:45 -0500
Date: Fri, 20 Jan 2006 00:44:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: axboe@suse.de, alan@lxorguk.ukuu.org.uk, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
Message-Id: <20060120004456.190f451b.akpm@osdl.org>
In-Reply-To: <1137745995.30084.201.camel@localhost.localdomain>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	<1137648119.30084.94.camel@localhost.localdomain>
	<20060119171708.7f856b42.sfr@canb.auug.org.au>
	<1137664692.8471.21.camel@localhost.localdomain>
	<20060119155933.GX4213@suse.de>
	<1137745995.30084.201.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2006-01-19 at 16:59 +0100, Jens Axboe wrote:
> > I think the CodingStyle suggestion of 80 chars is just fine. I try to
> > stay within that, and I mostly succeed. The occasional over-the-line is
> > far better than advocation >> 80 chars per line imho.
> 
> I agree. It's that "occasional over-the-line" which Andrew is mucking
> about with in the patch which started this thread; the case where it
> makes _sense_ to let it go over 80 characters rather than wrapping it.
> 

Oh crap.  The damn thing wraps into column _1_ and gets tangled up with
ifdef statements, function definitions and other things which _should_ go
in column one.

It .looks.  .like.  .crap.  to many other people, and saying random stupid
wrong things doesn't alter that very simple fact.

