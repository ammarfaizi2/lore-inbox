Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVCFLWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVCFLWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 06:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVCFLWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 06:22:18 -0500
Received: from mail.dif.dk ([193.138.115.101]:46557 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261362AbVCFLWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 06:22:16 -0500
Date: Sun, 6 Mar 2005 12:23:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
In-Reply-To: <20050304222146.GA1686@kroah.com>
Message-ID: <Pine.LNX.4.62.0503061220330.2909@dragon.hygekrogen.localhost>
References: <20050304222146.GA1686@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Greg KH wrote:

> Anything else anyone can think of?  Any objections to any of these?
> I based them off of Linus's original list.
> 

How about feature regressions?  What made me think of this is the thread 
about the 8x0 alsa breakage in 2.6.11. 2.6.10 and 2.6.9 worked well for 
people, but 2.6.11 is aparently broken for some. When that bug gets fixed 
would such a fix be appropriate for 2.6.10.y (assuming it doesn't violate 
any of your other guidelines) ?


-- 
Jesper
