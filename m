Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVAFUSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVAFUSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVAFUQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:21 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22721 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263008AbVAFUKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:10:39 -0500
Date: Thu, 6 Jan 2005 20:22:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: eme@v003.vaio.ne.jp
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: QUESTION: What's the difference between MCYRIXIII and MVIAC3_2
Message-ID: <20050106192231.GJ3096@stusta.de>
References: <20041231200350.eme@v003.vaio.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041231200350.eme@v003.vaio.ne.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 08:03:50PM +0900, eme@v003.vaio.ne.jp wrote:
> Hi all,
> 
> I have a question to ask.
> When compiling the kernel, there's a option to select
> the Processor type and features.
> 
> In kernel 2.6.7, I see two options for C3 Processors.
> I could see that MCYRIXIII is for C3 processors that's not Nehemiah core.
> And MVIAC3_2 is for C3 processors that is Nehemiah core.
> 
> In the help it says that MCYRIXIII kernel doesn't work with
> Nehemiah core, and MVIAC3_2 kernel doesn't work with C3 processor,
> not Nehemiah core.
> But my PC(Nehemiah core) has been working fine with MCYRIXIII,
> which in the help says, it's not gonna work with Nehemiah.
> I compiled another kernel with MVIAC3_2, which also works fine.
>...

That's interesting.

Please send the output of "cat /proc/cpuinfo" on your computer.

> Thanks in advance.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

