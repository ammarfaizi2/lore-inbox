Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTHYS2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbTHYS2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:28:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12951 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262129AbTHYS2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:28:31 -0400
Date: Mon, 25 Aug 2003 20:28:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, Lou Langholtz <ldl@aros.net>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
Message-ID: <20030825182826.GC863@suse.de>
References: <20030821193728.GB19630@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0308211254360.1606-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308211254360.1606-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21 2003, Linus Torvalds wrote:
> 
> On Thu, 21 Aug 2003, Matthew Wilcox wrote:
> > 
> > But why is it interesting to have this information at boot time?  As a
> > user, I certainly don't care.  As a developer, I don't find it interesting
> > information.
> 
> I do agree. The message may have been useful when the code was young and 
> people wanted to see that it got executed correctly at all, but there 
> doesn't seem to be a lot of point to it any more.
> 
> But hey, I'll leave it to the maintainer..

Willy's patch is fine with me as well. Purpose of the messages is long
gone.

-- 
Jens Axboe

