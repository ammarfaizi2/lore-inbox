Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVJCTlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVJCTlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVJCTlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:41:50 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:782 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932611AbVJCTlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:41:49 -0400
Message-ID: <43418990.8060004@tmr.com>
Date: Mon, 03 Oct 2005 15:42:08 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Rocha <frocha@student.dei.uc.pt>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [KORG] Kernel Panic
References: <43414E0A.3090506@student.dei.uc.pt>
In-Reply-To: <43414E0A.3090506@student.dei.uc.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Rocha wrote:
> Hi linux-kernel staff.
> 
>    I have a big problem!

And a good place to find an answer is on usenet. Ask your question in 
the comp.os.linux.setup newsgroup, and undoubtedly someone will have 
thoughts on your problem.

>    Each time I try to intall an Linux OS, on my machine, it crashes
> with "Kernel Panic"!
>    I tried to install
>    - "Fedora 4"
>    - "Kurumin 4.0"
>    - "Kurumin 5.0"
> 
>    In fact, "Kurumin" is a Live CD, and worked as an Live CD ONLY,
> although,
> when I tried to install it on my hard drive, it failed the
> initialization after the LILO run!!!
>    None of the Linux OS were able to detect the best "window size" of
> the screen,
> so I had to manually input it!!

This has nothing to do with the kernel, it's part of the setup routines. 
And why do you think any system can choose your preference in 
resolution, your hardware doesn't have the USB mind-reader.

> 
>    These are the components of my machine:
> 
> Motherboard
>    ASUS P5GDC-V Deluxe LGA775 i915G
>    DDR2, PCI-e, GLAN
> 
> CPU
>    Intel Pentium IV, 530, 3.0 GHz
>    1MB LGA775, with Hyperthreading.
> 
> RAM
>    Kingston 512MB DDR
>    400MHz CL3
> 
> 3D Board
>    Intel 82915G Express Chipset Family
>    Internal, 64 MB
> 
> Hard Drive
>    Western Digital, 120 GB
>    7200rpm, 8MB Bf. SATA
> 
> 
> Could it be something about the "Hyperthreading" thing, or hard drive
> being SATA,
> or maybe the 3D Board because of not detecting it??
> Could you please help me?
> 
> 
> Best Regards,
> Fernando Rocha
> 


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
