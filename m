Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUKSMJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUKSMJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbUKSMHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:07:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54280 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261371AbUKSMFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:05:30 -0500
Date: Fri, 19 Nov 2004 13:05:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119120523.GA22981@stusta.de>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119103418.GB30441@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:34:19AM +0100, Andi Kleen wrote:
>...
> In addition such a change is quite intrusive and I don't
> think it's a good idea to do right now because it'll very
> likely introduce bugs.
>...

I's say it will fix some bugs and make some future bugs less likely.

The CONFIG_LBD example in my initial mail is an example for such a bug.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

