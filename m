Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934435AbWKXGFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934435AbWKXGFO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 01:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934436AbWKXGFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 01:05:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51663 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S934435AbWKXGFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 01:05:11 -0500
Message-ID: <45668B9E.60008@jp.fujitsu.com>
Date: Fri, 24 Nov 2006 15:05:18 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org>
In-Reply-To: <20061124051217.GB8202@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Fri, Nov 24, 2006 at 09:38:00AM +0900, Hidetoshi Seto wrote:
>> Grant Grundler wrote:
>>> Hidetoshi,
>>> I have a nearly finished rewrite of Documentation/pci.txt.
>>> Can you drop this patch for now on my promise to integrate
>>> your proposed text?
>> No problem at all.
> 
> Thanks - I've posted pci.txt-05 on:
> 	http://www.parisc-linux.org/~grundler/pci.txt-05
> 
> and appended it below.
> 
> pci.txt-03 is the last version I posted.
> pci.txt-04 contains all feedback from Andi Kleen and Randi Dunlap
>            (plus a few other minor changes)
> pci.txt-05 reverts pci_enable_device/pci_request_resource ordering to
> 	reflect current reality. But I've added a comment to remind us
> 	about the issue. Also added Section 10/11 from Hidetoshi-san.
> 	A few minor other changes as well.
> 
> If this looks good, I'll post a diff for gregkh.
> 
> thanks,
> grant

Thank you very much!

I confirmed few minor fixes in section 10/11.
I ACK them.

Yes, this looks good. Please take your turn, Greg.

Thanks,
H.Seto

