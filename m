Return-Path: <linux-kernel-owner+w=401wt.eu-S1751108AbXACUDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbXACUDm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbXACUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:03:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4638 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751108AbXACUDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:03:42 -0500
Date: Wed, 3 Jan 2007 21:03:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Vivek Goyal <vgoyal@in.ibm.com>, Jean Delvare <khali@linux-fr.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.20-rc3: known unfixed regressions
Message-ID: <20070103200344.GH20714@stusta.de>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070102191606.GU20714@stusta.de> <microsoft-free.87bqlgvuxl.fsf@youngs.au.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <microsoft-free.87bqlgvuxl.fsf@youngs.au.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 04:15:02AM +1000, Steve Youngs wrote:
> * Adrian Bunk <bunk@stusta.de> writes:
> 
>   > Subject    : kernel immediately reboots
>   > References : http://lkml.org/lkml/2007/1/2/15
>   > Submitter  : Steve Youngs <steve@youngs.au.com>
>   > Status     : unknown
> 
> I'm very happy to report that this is now fixed for me.  See commit
> c6b33cc4e9882b44f1b0c36396f420076e04a4e2.
> 
> Thanks very much for the fast response and fix.

Thanks for both your bug report and your confirmation that it's fixed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

