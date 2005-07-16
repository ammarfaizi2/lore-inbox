Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVGPRCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVGPRCF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVGPRCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:02:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261701AbVGPRCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:02:04 -0400
Date: Sat, 16 Jul 2005 19:02:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: Linux 2.6.12.3
Message-ID: <20050716170202.GA3613@stusta.de>
References: <20050716044815.GA10063@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716044815.GA10063@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 09:48:16PM -0700, Greg KH wrote:
>...
> Summary of changes from v2.6.12.2 to v2.6.12.3
> ==============================================
>...
> Ralf Baechle:
>   SMP fix for 6pack driver
>...

Will this patch [1] also be forward-ported to Linus' tree, or will 
2.6.12.3 stay the _only_ 2.6 kernel that ever offered this driver for 
SMP configs?

cu
Adrian

[1] "fix" is a wrong patch description since all it does is to remove 
    the BROKEN_ON_SMP dependency

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

