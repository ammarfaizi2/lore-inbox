Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbVJCWHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVJCWHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVJCWHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:07:33 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27910 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932719AbVJCWHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:07:32 -0400
Date: Tue, 4 Oct 2005 00:07:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: util-linux and data encryption
Message-ID: <20051003220729.GJ3652@stusta.de>
References: <4341567E.4050603@esoterica.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4341567E.4050603@esoterica.pt>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 05:04:14PM +0100, Paulo da Silva wrote:

> If this is not the right place to post about
> util-linux, please tell me where to post.
> I'm posting here because util-linux is at kernel.org.
>...

If you have problems with some software shipped with a distribution the
best choice is usually the support / bug tracking system of your
distribution.

In your case, the problem seems to be already reported as Gentoo
bug #107680 [1].

> BTW, I am using gentoo and I also tried USE=old-crypt.
> No way!
> 
> I needed to install the version 2.12i to recover
> my information.
> 
> Is this related with util-linux or has something
> to do with gentoo patches or something?
>...

You are using features not present in the upstream util-linux but added 
by patches Gentoo applies.

> Thank you for any comments.

cu
Adrian

[1] http://bugs.gentoo.org/107680

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

