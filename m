Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVK1AZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVK1AZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 19:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVK1AZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 19:25:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38155 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751202AbVK1AZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 19:25:24 -0500
Date: Mon, 28 Nov 2005 01:25:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer dereference
Message-ID: <20051128002523.GA31395@stusta.de>
References: <20051126233736.GE3988@stusta.de> <52irud4pki.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52irud4pki.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 03:51:41PM -0800, Roland Dreier wrote:

> Thanks, I already have this in my git tree of pending changes
> (I found it by actually hitting the crash it causes with CONFIG_DEBUG_SLAB=y).

Can you Cc me when forwarding it to Linus?

After it's in Linus' tree, Greg will accept it for the 2.6.14 stable
tree.

>  - R.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

