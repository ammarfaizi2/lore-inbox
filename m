Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUFTFKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUFTFKa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFTFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 01:10:30 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:62802 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263881AbUFTFKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 01:10:24 -0400
Message-ID: <40D51C3C.3050804@yahoo.com.au>
Date: Sun, 20 Jun 2004 15:10:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops inserting USB storage device
References: <Pine.LNX.4.58.0406192049430.2228@montezuma.fsmlabs.com> <20040620044315.GB10008@kroah.com>
In-Reply-To: <20040620044315.GB10008@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Jun 19, 2004 at 08:52:40PM -0400, Zwane Mwaikambo wrote:
> 
>>I got the following upon insertion of said USB device. Did the kobject get
>>freed?
> 
> 
> What kernel version?
> 

Zwane Mwaikambo wrote:
 >
 > Unable to handle kernel paging request at virtual address ded28d08
 >  printing eip:
 > c032de76
 > *pde = 0007d067
 > Oops: 0002 [#1]
 > PREEMPT SMP DEBUG_PAGEALLOC
 > Modules linked in:
 > CPU:    0
 > EIP:    0060:[<c032de76>]    Not tainted
 > EFLAGS: 00010296   (2.6.7)
                       ^^^^^
