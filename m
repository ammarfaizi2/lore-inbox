Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTDXWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTDXWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:39:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32760 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264459AbTDXWj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:39:57 -0400
Date: Fri, 25 Apr 2003 00:51:58 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424225158.GD15833@fs.tum.de>
References: <20030424051510.GK8931@holomorphy.com> <Pine.LNX.4.44.0304232217550.19326-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304232217550.19326-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 10:43:37PM -0700, Linus Torvalds wrote:
>...
> And hey, the fact is (at least as far as I'm concerned), that as long as
> you make the hardware, you can control what it runs.
>...

Linux is currently widely used and through this there comes some power. 
Let me try to make examples where this might be important:

Fact is:
Cryptographic hardware isn't science fiction. It's not an unsolvable 
technical problem to build a computer and to ensure that only 
$signed_kernel with $binary_only_module loaded and no other modules 
loaded runs on this computer.

Two examples that might make it very important whether the licence of 
Linux allows things like:
1. all the companies participating in TCPA agree that only selected 
   signed kernels run on future hardware
2. [less likely] a big country like the USA makes a law that every OS 
   must include a backdoor that allows unnoticed access for the NSA (it 
   sounds strange but considering the DMCA and current legislative 
   proposals in the USA I wouldn't say this is completely impossible)

That's the point where the fact that Linux is used in many companies 
including big ones becomes important:

For companies it wouldn't be a big problem to use only signed kernels in 
a scenario like the first one above (because of support rules of 
companies like Oracle or SAP they are already often tied to some 
specific kernels) if the licence of Linux allows it.

If the licence of Linux doesn't allow this it would make many of the big 
companies using Linux to opposers of such a proposal.

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

