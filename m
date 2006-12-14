Return-Path: <linux-kernel-owner+w=401wt.eu-S1751582AbWLNF0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWLNF0i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWLNF0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:26:38 -0500
Received: from smtp43.singnet.com.sg ([165.21.103.151]:47474 "EHLO
	smtp43.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbWLNF0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:26:37 -0500
X-Greylist: delayed 8295 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 00:26:37 EST
Message-ID: <4580C054.2080902@homeurl.co.uk>
Date: Thu, 14 Dec 2006 11:09:08 +0800
From: Bob <spam@homeurl.co.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 SMP very slow with ServerWorks LE Chipset
References: <4577AA11.6020906@homeurl.co.uk>
In-Reply-To: <4577AA11.6020906@homeurl.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob wrote:
> Hi I have a dual PIII Motherboard based on a ServerWorks LE chipset,
> the motherboard is from an HP Netserver E 800 which is a customised ASUS 
> CUR-DLS.
> 
> in UP config everything is OK in SMP the system slows right down, I've 
> been searching and recompiling my kernel for days looking for the 
> problem option without success, please help.

8< major snip 8<  tactfully ignoring the self quote 8<

I'm going away tomorrow and won't be back until January, (though if 
anyone has any bright ideas please post them now and I'll try them 
tomorrow or in Jan) I'll resurrect this thread then.

As per Alan's suggestion I decompressed the kernel source tree with the 
processes pegged to one CPU then the other, and as he predicted it took 
vastly longer on one CPU than the other, but I don't know what that 
implies, or how to fix it.

Arjan van de Ven Suggested I run the Linux-ready Firmware Developer Kit 
on the machine, I've done that the results are here.
http://www.homeurl.co.uk/linuxfirmwarekit/

If you missed the thread (and with a high volume mail group like this 
it's easy to do) it's available on the gooja
http://groups.google.com/group/linux.kernel/browse_frm/thread/79f7f9fa39165f55/0e1e7428a54212b5?tvc=1#0e1e7428a54212b5

I really appreciate any help, I've got 3 big harddrives in this box 
waiting to go into a RAID5 array to replace my ad hoc collection of 
drives scattered around the network with a data on, most of it backed up 
or replicated but some not, and as you can imagine I'm feeling a bit 
exposed.

Thanks
