Return-Path: <linux-kernel-owner+w=401wt.eu-S965119AbXADWZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbXADWZP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbXADWZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:25:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3539 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965119AbXADWZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:25:14 -0500
Date: Thu, 4 Jan 2007 23:25:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.37
Message-ID: <20070104222517.GL20714@stusta.de>
References: <200612311709_MC3-1-D6E2-720A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612311709_MC3-1-D6E2-720A@compuserve.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 05:05:55PM -0500, Chuck Ebbert wrote:
> In-Reply-To: <20061228135308.GB20714@stusta.de>
> 
> On Thu, 28 Dec 2006 14:53:08 +0100, Adrian Bunk wrote:
> 
> > Changes since 2.6.16.36:
> > ...
> 
> If you're not going to merge the critical x86 fixes I sent,
> I won't bother sending anything more.

Sorry, they didn't went in before 2.6.16.37-rc1, and except for 
releasing 2.6.16.37-rc1 unchanged as 2.6.16.37 I didn't work on 2.6.16 
during christmas and new year.

I've now applied all three patches.

There's already a CVE number for
"i386: save/restore eflags in context switch".

Are there also CVE numbers for the equivalent x86_64 patch and
"x86_64: fix ia32 syscall count"?

Thanks for your patches
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

