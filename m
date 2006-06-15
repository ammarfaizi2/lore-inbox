Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWFOPZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWFOPZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWFOPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:25:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20353 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030672AbWFOPZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:25:58 -0400
Message-ID: <44917BFE.1070604@garzik.org>
Date: Thu, 15 Jun 2006 11:25:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Gord Peters <GordPeters@smarttech.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: SATA: Marvell 88SE6141 support?
References: <A6F7DE24-36C7-4FDB-AB2A-2C63478F0D0A@smarttech.com> <44916C5B.5000402@rtr.ca>
In-Reply-To: <44916C5B.5000402@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Gord Peters wrote:
>> Hi,
>>
>> I was just wondering what the status of development is in regard to 
>> support for the Marvell 88SE6141 (ie. mv61xx) SATA-II controller is?  
>> This particular controller is included on the Asus P5WD2-E Premium 
>> motherboard.
> 
> First I've heard of it.  Can you find docs for it?
> If so, post a link to them, and we'll have a look to see what is 
> different from the 60xx series.

I would be willing to bet that it's either GEN-IIE or something that 
sata_mv doesn't cover at all (like AHCI).

	Jeff



