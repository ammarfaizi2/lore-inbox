Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284867AbRLKD5j>; Mon, 10 Dec 2001 22:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284871AbRLKD53>; Mon, 10 Dec 2001 22:57:29 -0500
Received: from mail114.mail.bellsouth.net ([205.152.58.54]:31749 "EHLO
	imf14bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284867AbRLKD5N>; Mon, 10 Dec 2001 22:57:13 -0500
Message-ID: <3C158501.2010506@mindspring.com>
Date: Mon, 10 Dec 2001 23:01:05 -0500
From: Jonathan Stanford <jomast@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB + PCI - IRQ = kernel bug??
In-Reply-To: <mailman.1008041221.4721.linux-kernel2news@redhat.com> <200112110342.fBB3gQe19601@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>what i find interesting is that no interrupts are being sent
>>see for yourself here --> http://quail.no-ip.com/interrupts.txt
>>
>
>Your BIOS is broken.
>
it's got the latest flash........
and as much as i dont like saying this out loud......  it all works in 
win2k.....

>
>
>>i've removed just about all devices from the system.... and there is no 
>>change....
>>
>
>You should have posted the log as it looks _after_ pulling
>the SCSI card.
>
>Another thing to try is to use a 2.7.9-x kernel from RH updates
>for 7.2 and use "apic" parameter. See if that helps.
>
i've try'd that kernel...... same results.....

"apic" ??

>
>-- Pete
>



