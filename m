Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVCXKEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVCXKEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVCXKEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:04:49 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:50137 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262437AbVCXKEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:04:42 -0500
Message-ID: <42429244.1070903@qazi.f2s.com>
Date: Thu, 24 Mar 2005 10:11:16 +0000
From: Asfand Yar Qazi <ay1204@qazi.f2s.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041010
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <3Lxis-5a0-29@gated-at.bofh.it> <3Lxis-5a0-31@gated-at.bofh.it> <3Lxis-5a0-33@gated-at.bofh.it> <3Lxis-5a0-27@gated-at.bofh.it>
In-Reply-To: <3Lxis-5a0-27@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asfand Yar Qazi wrote:
> Arjan van de Ven wrote:
> 
>>> * "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't 
>>> support
>>> it in any case.
>>>
>>
>>
>> probably just one of those things implemented in the binary drivers in
>> software, just like the "hardware" IDE raid is most of the time (3ware
>> being the positive exception there)
>>
> 
> http://www.neoseeker.com/Articles/Hardware/Previews/nvnforce4/3.html
> 
> You're right there - some semi-hardware support combined with drivers 
> apparently result in lower CPU usage that software firewalls.  Apparently.
> 
> Actually, these people like it:
> http://www.bjorn3d.com/read.php?cID=712&pageID=1096
> 
> However one feature that you can't laugh at is the fact that it can be 
> made to block packets in the span of time between the OS being loaded 
> up, and the "real" firewall coming up.  This small time span 
> theoretically leaves the PC vulnerable, so I think this is the only use 
> for "ActiveAmor Firewall".
> 
> However, this doesn't answer my original question (which I suppose I 
> should have made clearer): can I get SATA II NCQ support in Linux with 
> an nForce 4 chipset?
> 
> 

Argh already been answered.  Another question: which add-in SATA RAID 
boards (preferably in PCI Express flavour) support NCQ fully and will 
be fully supported in Linux?
