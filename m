Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312104AbSC2Vcf>; Fri, 29 Mar 2002 16:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312134AbSC2VcZ>; Fri, 29 Mar 2002 16:32:25 -0500
Received: from www.wotug.org ([194.106.52.201]:64522 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S312119AbSC2VcN>; Fri, 29 Mar 2002 16:32:13 -0500
Message-Id: <5.1.0.14.0.20020329210032.00b82b38@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 29 Mar 2002 21:32:02 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Request for 2.4.20 to be a non-trivial-bugfixes-only
  version
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <E16qzE4-0001Vm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:27 29/03/2002 +0000, Alan Cox wrote:
>Its somewhat naiive. If you have a hole in a bridge and someone tells you
>that for stability you can only paint the bridge and tighten bolts you will
>still have a very broke bridge. Ditto with software.
>
>2.2.20 is stable because its been slowly refined to that and is now at the
>point where on the hole the painting and bolt tightening is all that needs
>doing. The 2.4 tree suffered serious earthquake damage in 2.4.10 which
>hasn't entirely been fixed yet.

Please note I didn't say .20 *and all future versions*. I asked because it 
just seems to me that while kernel 2.4 is definitely improving, it is being 
pulled hard in 2 directions -- towards stability and towards 2.5.

I was hoping that, if we had a release that was focused on stability, the 
current code base might get a longer testing phase, resulting in a better 
code base overall.

I have been involved in professional software engineering for many years -- 
I know how things go and how basic structure affects things. However, I 
also know (from my own experience) that bug fixing is not nearly as 
exciting as developing some new feature, or getting a chunk of code "just 
right", when it worked ok to begin with.  My commercial experience is that, 
at the end of a project, introducing significant changes of any type is 
something you do rarely and with great care; even the best engineer 
sometimes misses an important side-issue and messes up.

I guess I might be digging a hole here, but I'm trying hard to make Linux 
better for us all.

Ruth

