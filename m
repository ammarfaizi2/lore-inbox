Return-Path: <linux-kernel-owner+w=401wt.eu-S1422710AbXAMQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbXAMQVG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbXAMQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 11:21:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4005 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422710AbXAMQVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 11:21:03 -0500
Date: Sat, 13 Jan 2007 17:21:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <rdreier@cisco.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Miles Lane <miles.lane@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       avi@qumranet.com, kvm-devel@lists.sourceforge.net,
       Russell King <rmk+lkml@arm.linux.org.uk>, vojtech@suse.cz,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.20-rc5: known regressions with patches
Message-ID: <20070113162108.GQ7469@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070113071412.GH7469@stusta.de> <adaps9j54dd.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaps9j54dd.fsf@cisco.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 07:32:46AM -0800, Roland Dreier wrote:
>  > This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19
>  > with patches available.
> 
>  > Subject    : KVM: guest crash
>  > References : http://lkml.org/lkml/2007/1/8/163
>  > Submitter  : Roland Dreier <rdreier@cisco.com>
>  > Handled-By : Avi Kivity <avi@qumranet.com>
>  > Patch      : http://lkml.org/lkml/2007/1/9/280
>  > Status     : patch available
> 
> This is not a regression from 2.6.19, since kvm did not exist in
> 2.6.19.  In any case akpm has the patch and plans to merge it for
> 2.6.20 so I don't think anyone has to worry about this one.

I know, but a bug that is not present in 2.6.19 is a regression. ;-)

More seriously, I know it's a bit borderline to talk about a regression, 
but I think listing things like crashes or compile errors in new 
functionality makes sense - especially in such cases where it's about 
tracking that a patch doesn't miss 2.6.20.

>  - R.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

