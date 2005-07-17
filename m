Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVGQNc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVGQNc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVGQNc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 09:32:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30475 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261281AbVGQNcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 09:32:25 -0400
Date: Sun, 17 Jul 2005 15:32:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] sparc: remove the useless APM_RTC_IS_GMT option
Message-ID: <20050717133222.GF3613@stusta.de>
References: <20050715203632.GD18059@stusta.de> <1121460211.2755.114.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121460211.2755.114.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 03:43:31PM -0500, Tom 'spot' Callaway wrote:
> On Fri, 2005-07-15 at 22:36 +0200, Adrian Bunk wrote:
> > I can't see any effect of this option outside the i386-specific APM 
> > code.
> 
> Doesn't the Javastation potentially use this?

I don't know whether the Javastation supports APM, but the whole APM 
code in the kernel is currently only available on i386.

> ~spot

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

