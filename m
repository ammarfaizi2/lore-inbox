Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbTHUTzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 15:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbTHUTzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 15:55:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:62887 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262891AbTHUTzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 15:55:50 -0400
Date: Thu, 21 Aug 2003 12:55:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <willy@debian.org>
cc: Lou Langholtz <ldl@aros.net>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
In-Reply-To: <20030821193728.GB19630@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0308211254360.1606-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Aug 2003, Matthew Wilcox wrote:
> 
> But why is it interesting to have this information at boot time?  As a
> user, I certainly don't care.  As a developer, I don't find it interesting
> information.

I do agree. The message may have been useful when the code was young and 
people wanted to see that it got executed correctly at all, but there 
doesn't seem to be a lot of point to it any more.

But hey, I'll leave it to the maintainer..

		Linus

