Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280591AbRKBHxA>; Fri, 2 Nov 2001 02:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280593AbRKBHwu>; Fri, 2 Nov 2001 02:52:50 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:40170 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S280591AbRKBHwg>; Fri, 2 Nov 2001 02:52:36 -0500
Message-ID: <A9B0C3C90A46D411951400A0C9F4F67103BA56E3@pdsmsx33.pd.intel.com>
From: "Yan, Noah" <noah.yan@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: vm documentation
Date: Fri, 2 Nov 2001 15:53:21 +0800 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any resources(such as programming guide or referrence book) for the C language grammar in gcc, especially for Kernel? Such as what is _init, 1<<12, asmlinkage, etc?

Thanks
Noah

-----Original Message-----
From: Robert Love [mailto:rml@tech9.net]
Sent: 2001?11?2? 15:23
To: David Chow
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm documentation


On Fri, 2001-11-02 at 01:53, David Chow wrote:
> Is there any documentation of the recent changes of the vm in the linux
> kernel? Also, is there any source of documentation to get start with the
> linux kernel hacking? It is hard for people to getting start to
> contribute since is is obviously lack of documentation of the kernel
> sources... Any help will be appreciated. Thanks.

See http://kernelnewbies.org for some introduction to kernel hacking...

The books "Understanding the Linux Kernel" and "Linux Device Drivers",
both published by O'Reilly, are good starts.

As for the VM, there doesn't seem to be _anything_ yet.  Hopefully soon?

	Robert Love

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
