Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVC1KE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVC1KE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 05:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVC1KE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 05:04:57 -0500
Received: from mail.dif.dk ([193.138.115.101]:22751 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261481AbVC1KEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 05:04:55 -0500
Date: Mon, 28 Mar 2005 12:06:52 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Colin Leroy <colin@colino.net>
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix shared key auth in zd1201
In-Reply-To: <20050328114904.09291da8@jack.colino.net>
Message-ID: <Pine.LNX.4.62.0503281203550.2459@dragon.hyggekrogen.localhost>
References: <20050328114904.09291da8@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Colin Leroy wrote:

> Hi,
> 
> this is a resend of a patch that Andrew put in -mm, but that I think is
> ok and should go into mainline. I did not get any feedback (positive or
> negative) about it. Please either apply it or explain why not...
> 
> It's currently impossible to associate with a shared-key-only access
> point using the zd1201 driver. The attached patch fixes it. The reason
[snip]

If Andrew merged it in -mm, then it's on the right track for mainline I'd 
say. Andrew seems to be quite good at keeping the experimental/needs 
testing stuff in -mm for a while to shake out the bugs, but at the same 
time let the rest migrate onwards to Linus fairly quickly... 
If it's currently in -mm I'd just relax and wait for it to hit mainline in 
2.6.12 or 2.6.13...


-- 
Jesper Juhl

