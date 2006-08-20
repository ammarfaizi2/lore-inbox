Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWHTW67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWHTW67 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWHTW67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:58:59 -0400
Received: from 1wt.eu ([62.212.114.60]:64016 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751787AbWHTW66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:58:58 -0400
Date: Mon, 21 Aug 2006 00:58:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Solar Designer <solar@openwall.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Message-ID: <20060820225823.GD602@1wt.eu>
References: <20060819234629.GA16814@openwall.com> <1156097717.4051.26.camel@localhost.localdomain> <20060820223442.GA21960@openwall.com> <1156115468.4051.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156115468.4051.80.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 12:11:08AM +0100, Alan Cox wrote:
> Ar Llu, 2006-08-21 am 02:34 +0400, ysgrifennodd Solar Designer:
> > Do you really think that getting this fix into 2.4 should be delayed
> > like that? 
> 
> I have no problem with it going into 2.4. Someone should forward port it
> - but there should be plenty of people on the lists to do that.

That's so true ! We're relying too much on our own time while many people
might be waiting for some little work to start taking a look at the kernel
internals !

I think I will be starting to ask for forward porters for the fixed to 2.4
that need to be ported to 2.6 too.

Cheers,
Willy

