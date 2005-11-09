Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbVKIXB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbVKIXB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVKIXB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:01:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751072AbVKIXBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:01:55 -0500
Date: Wed, 9 Nov 2005 15:01:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       jgarzik@pobox.com, tony.luck@intel.com, bcollins@debian.org,
       scjody@modernduck.com, dwmw2@infradead.org, rolandd@cisco.com,
       davej@codemonkey.org.uk, axboe@suse.de, shaggy@austin.ibm.com,
       sfrench@us.ibm.com
Subject: Re: merge status
Message-Id: <20051109150141.0bcbf9e3.akpm@osdl.org>
In-Reply-To: <1131575124.8541.9.camel@mulgrave>
References: <20051109133558.513facef.akpm@osdl.org>
	<1131573041.8541.4.camel@mulgrave>
	<Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
	<1131575124.8541.9.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> it's my contributors who drop me in it
> by leaving their patch sets until you declare a kernel, dumping the
> integration testing on me in whatever time window is left.

Yes, I think I'm noticing an uptick in patches as soon as a kernel is
released.

It's a bit irritating, and is unexpected (here, at least).  I guess people
like to hold onto their work for as long as possible so when they release
it, it's in the best possible shape.

I guess all we can do is to encourage people to merge up when it's working,
not when it's time to merge it into mainline.

One could just say "if I don't have it by the time 2.6.n is released, it
goes into 2.6.n+2", but that's probably getting outside the realm of
practicality.
