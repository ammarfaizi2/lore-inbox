Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVCDJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVCDJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCDJ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:26:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:31173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVCDJWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:22:23 -0500
Date: Fri, 4 Mar 2005 01:21:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304012154.619948d7.akpm@osdl.org>
In-Reply-To: <20050304091612.GG14764@suse.de>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<20050303234523.GS8880@opteron.random>
	<20050303160330.5db86db7.akpm@osdl.org>
	<20050304025746.GD26085@tolot.miese-zwerge.org>
	<20050303213005.59a30ae6.akpm@osdl.org>
	<1109924470.4032.105.camel@tglx.tec.linutronix.de>
	<20050304005450.05a2bd0c.akpm@osdl.org>
	<20050304091612.GG14764@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Fri, Mar 04 2005, Andrew Morton wrote:
>  > The average user has learnt "rc1 == pre1".  I don't expect that it
>  > matters much at all.
> 
>  The average user and lkml reader, perhaps. But I don't understand
>  why Linus refuses to use proper -preX/-rcX naming

Me either.  And because people just will insist on arbitrarily dinking with
Cc: lines, he's not listening to us any more.

There.  Fixed.
