Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVINPZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVINPZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbVINPZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:25:14 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15121 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965246AbVINPZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:25:13 -0400
Message-ID: <4328425C.10803@tmr.com>
Date: Wed, 14 Sep 2005 11:31:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
> and that means that the merge window is closed. I've released a 
> 2.6.14-rc1, and we're now all supposed to help just clean up and fix 
> everything, and aim for a really solid 2.6.14 release.
> 
> Both the diffstat and the shortlog are so big that I can't post them on 
> the kernel mailing list without getting the email killed by the size 
> restrictions, so there's not a lot to say. 
> 
> alpha, arm, x86, x86-64, ppc, ia64, mips, sparc, um.. Pretty much every
> architecture got some updates. And an absolutely _huge_ ACPI diff, largely 
> because of some re-indentation.
> 
> drm, watchdog, hwmon, i2c, infiniband, input layer, md, dvb, v4l, network,
> pci, pcmcia, scsi, usb and sound driver updates. People may appreciate
> that the most common wireless network drivers got merged - centrino
> support is now in the standard kernel.

Was there some problems with the current version of the ipw2200 driver 
(1.0.6) which required using the 1.0.0 version from several years ago?

And is the Centrino "modem" now working? Or just the wireless?

Good to see all this work, but I suspect it will be a long debug cycle 
as people shake it out. I will probably build it tonight, try it tomorrow.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
