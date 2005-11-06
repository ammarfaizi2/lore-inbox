Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVKFMj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKFMj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 07:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVKFMj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 07:39:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44304 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750745AbVKFMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 07:39:56 -0500
Date: Sun, 6 Nov 2005 13:39:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: jerome lacoste <jerome.lacoste@gmail.com>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
Message-ID: <20051106123954.GB3847@stusta.de>
References: <436C7E77.3080601@ed-soft.at> <20051105122958.7a2cd8c6.khali@linux-fr.org> <436CB162.5070100@ed-soft.at> <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com> <436DEF22.4010903@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436DEF22.4010903@ed-soft.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 12:55:14PM +0100, Edgar Hucek wrote:
> jerome lacoste wrote:
>...
> >On a server you want stability. So you don't upgrade.
> 
> Sure, but what about securrity updates. When a new kernel release
> comes out the updates are stopped for older releases. And why should
> dirstribution makers always backport new security fixes ?
>...

Because it's their job.

As long as a vendor supports a release of his distribution, the absolute 
minimum he has to provide are regular security fixes for all the 
software the release offers - including the kernels shipped with the 
release.

E.g. the latest security update RedHat offered for the kernel 2.4.9 (sic) 
used in their version 2.1 server products was two months ago.
And they will provide security updates until 2009.

> cu
> 
> ED.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

