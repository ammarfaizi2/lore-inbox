Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUFCIcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUFCIcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUFCIcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:32:24 -0400
Received: from [213.239.201.226] ([213.239.201.226]:29103 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261791AbUFCIbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:31:42 -0400
Message-ID: <40BEE36D.4060408@shadowconnect.com>
Date: Thu, 03 Jun 2004 10:38:05 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       root@chaos.analogic.com
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <40BDF1AC.7070209@shadowconnect.com> <Pine.LNX.4.53.0406021144280.559@chaos> <200406031241.27669.cef-lkml@optusnet.com.au> <40BE923F.7070601@pobox.com>
In-Reply-To: <40BE923F.7070601@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
>>> I asked for the output of `cat /proc/pci` . Unless I get that
>>> information, I can't find the length of the allocation.
>> Is there no way to to get this information out of lspci (eg: lspci 
>> -vv)? This is particularly annoying since /proc/pci is depreciated. I 
>> know a number of 
> You _can_ get that information out of lspci.

Could you tell me how, because lspci -v doesn't contain that 
information, and even with lspci -vv not all sizes are displayed?


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
