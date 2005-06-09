Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVFINJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVFINJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVFINHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:07:44 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:10113 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S262384AbVFINFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:05:20 -0400
Message-ID: <42A83E82.3040400@a-wing.co.uk>
Date: Thu, 09 Jun 2005 14:05:06 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sis5513.c patch take 2
References: <42A831E3.5080607@a-wing.co.uk> <58cb370e0506090533362dfbf0@mail.gmail.com>
In-Reply-To: <58cb370e0506090533362dfbf0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 6/9/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> 
>>Hi,
>>
>>Is this patch safer?  I am burn-in testing it now and it seems work fine
>>with UDMA transfers.  I added the PCI ID of the northbridge as suggested.
> 
> 
> Thanks, could you also try this simple debugging patch?
> [ without applying your patch ]

Not a problem, just compiled it, the result is trueid=0x180

> It may be possible to add generic 965L support just like 962/936L one
> (also NorthBridge<->SouthBridge mapping is not unique nowadays).

I was thinking that you said to use the NorthBridge

Regards
Andrew

-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 178: short leg on process table
