Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbVKWWkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbVKWWkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVKWWkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:40:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6813
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030441AbVKWWkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:40:10 -0500
Date: Wed, 23 Nov 2005 14:39:46 -0800 (PST)
Message-Id: <20051123.143946.41188551.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: jgarzik@pobox.com, bunk@stusta.de, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051123221547.GM15449@flint.arm.linux.org.uk>
References: <20051118090158.GA11621@flint.arm.linux.org.uk>
	<437DFD6C.1020106@pobox.com>
	<20051123221547.GM15449@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 23 Nov 2005 22:15:48 +0000

> I leave it up to you how to proceed.  Effectively I'm now completely
> out of the loop on this with no hardware to worry about.  Sorry.
> 
> Finally, please don't assign any blame for this in my direction; I
> reported it and I kept bugging people about it, and in spite of my
> best efforts there was very little which was forthcoming.  Obviously
> that wasn't enough.

I think you're being unreasonable.

They've worked on a fix for the problem, and now you're unable to test
the fix, and you're angry at them because they took so long to code up
the fix.

If you're overextended and have too much work to do and that's
stressing you out, that doesn't give you permission to take it
out on other people.
