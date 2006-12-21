Return-Path: <linux-kernel-owner+w=401wt.eu-S1030182AbWLULop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWLULop (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 06:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWLULop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 06:44:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41757 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964968AbWLULoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 06:44:44 -0500
Message-ID: <458A73A6.4010805@garzik.org>
Date: Thu, 21 Dec 2006 06:44:38 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: nigel@nigel.suspend2.net
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated Kernel Hacker's guide to git
References: <4589F9B1.2020405@garzik.org> <1166680407.3636.25.camel@nigel.suspend2.net>
In-Reply-To: <1166680407.3636.25.camel@nigel.suspend2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2006-12-20 at 22:04 -0500, Jeff Garzik wrote:
>> I refreshed my git intro/cookbook for kernel hackers, at 
>> http://linux.yyz.us/git-howto.html
>>
>> This describes most of the commands I use in day-to-day kernel hacking. 
>>   Let me know if there are glaring errors or missing key commands.
> 
> Thanks for the work! I'd suggest also saying how to repack and cleanup.

Yes, I should mention repacking.  When you say cleanup, what 
specifically do you mean?


> Could also be a good idea to go through the steps for uploading to
> master.kernel.org or elsewhere?

Yes, push should be mentioned at the very least.

	Jeff



