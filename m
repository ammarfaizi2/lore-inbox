Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSDKXuR>; Thu, 11 Apr 2002 19:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSDKXuQ>; Thu, 11 Apr 2002 19:50:16 -0400
Received: from web13203.mail.yahoo.com ([216.136.174.188]:64777 "HELO
	web13203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313027AbSDKXuP>; Thu, 11 Apr 2002 19:50:15 -0400
Message-ID: <20020411235015.78405.qmail@web13203.mail.yahoo.com>
Date: Thu, 11 Apr 2002 16:50:15 -0700 (PDT)
From: Aviv Shavit <avivshavit@yahoo.com>
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
To: Ken Brownfield <ken@irridia.com>, Andrea Arcangeli <andrea@suse.de>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020411183443.A21005@asooo.flowerfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This goes back to my previous post - 
Applying only the vm patches didn't get me far.

I'm still trying to pin point what it is thats helping
me out in -aa

--- Ken Brownfield <ken@irridia.com> wrote: 
:
:
> 
> How much of the improved behavior that you're seeing
> is due to the vm-33
> tweaks and not pte-highmem, block-highmem, or any of
> the 100 or so other
> 2.4.19-pre6aa1 patches?
:
:
> 
> What I'd like to hear (and what I suspect many
> admins trying to get
> higher-end hardware working optimally in a
> production environment would
> like to hear) is what specific patches applied to
> mainline are needed to
> correct the current VM and I/O issues in the 2.4
> tree?
> 
> If it's vm, pte-highmem, and block-highmem, that's
> fine -- and separable
> from -aa.  Otherwise it's difficult to get people to
> test, use, and
> provide feedback that isn't polluted by unnecessary
> variables.
> 
> Thanks,
> -- 
> Ken.
> ken@irridia.com
> 



__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
