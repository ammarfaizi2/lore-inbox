Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVK2Max@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVK2Max (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 07:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVK2Max
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 07:30:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22797 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751340AbVK2Max (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 07:30:53 -0500
Date: Tue, 29 Nov 2005 13:30:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer dereference
Message-ID: <20051129123052.GF31395@stusta.de>
References: <20051126233736.GE3988@stusta.de> <52irud4pki.fsf@cisco.com> <20051128002523.GA31395@stusta.de> <52psok1wne.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52psok1wne.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 09:59:17AM -0800, Roland Dreier wrote:
>     Adrian> Can you Cc me when forwarding it to Linus?
> 
> Looks like it went into Linus's tree directly from you (which is fine).

It went through Andrew.

>     Adrian> After it's in Linus' tree, Greg will accept it for the
>     Adrian> 2.6.14 stable tree.
> 
> Is this really important enough for the stable tree?

You said it fixed a crash for you.

Besides this, it's a small and easy to verify change.

>  - R.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

