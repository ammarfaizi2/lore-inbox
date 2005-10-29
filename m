Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVJ2MSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVJ2MSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 08:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVJ2MSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 08:18:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:774 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750800AbVJ2MSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 08:18:14 -0400
Date: Sat, 29 Oct 2005 14:18:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Per Jessen <per@computer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: building 2.4.31 for a non-smp system
Message-ID: <20051029121812.GK4180@stusta.de>
References: <20051029112755.C6F8B9801D@mail.local.net> <43635E2A.4010405@computer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43635E2A.4010405@computer.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 01:34:02PM +0200, Per Jessen wrote:
> > 
> > Please send:
> > - your .config
> 
> Attached.
>...

I can reproduce neither of your two problems.

I do vaguely remember that the 2.4 build system has problems handling 
changes of the CONFIG_SMP option correctly.

Is your problem reproducible when starting from a freshly unpacked 
2.4.31 tree?

cu
Adrian

BTW: Please don't strip people from the Cc when replying to 
     linux-kernel.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

