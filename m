Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCAAcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCAAcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCAAcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:32:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19211 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261151AbVCAAcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:32:48 -0500
Date: Tue, 1 Mar 2005 01:32:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050301003247.GY4021@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226013137.GO20715@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 02:31:37AM +0100, Andrea Arcangeli wrote:
> On Fri, Feb 25, 2005 at 10:14:54PM +0100, Adrian Bunk wrote:
> > You don't need this feature unless you know you need it.
> 
> But you may not know that you need it since in the help text I
> intentionally didn't mention which software requires the option to be
> set to Y (I didn't mention it, since I didn't want to use the kernel
> configuration help text to get free advertisement, but OTOH if people is
> unsure while they configure the kernel I certainly prefer that they set
> it to Y ;).
>...

If you want to use Cpushare, you know that you have to enable seccomp.

> Thanks.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

