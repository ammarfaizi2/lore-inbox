Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWI2Jxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWI2Jxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWI2Jxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:53:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51361 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751096AbWI2Jxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:53:42 -0400
Message-ID: <451CED23.1090909@garzik.org>
Date: Fri, 29 Sep 2006 05:53:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA status reports update
References: <451CE8EC.1020203@garzik.org> <200609291149.37009.prakash@punnoor.de>
In-Reply-To: <200609291149.37009.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Am Freitag 29 September 2006 11:35 schrieb Jeff Garzik:
>> I updated the info at http://linux-ata.org/ to match the current code in
>> linux-2.6.git.
>>
>> Hardware and driver status:
>> 	http://linux-ata.org/driver-status.html
>>    notably, the driver matrix:
>> 	http://linux-ata.org/driver-status.html#matrix
> 
> Does any ETA exists for NV NON-AHCI NCQ support? The proabably not so small 
> userbase would be happy if work on it would be done...

No ETA at all.  It is admittedly low priority, and unfortunately the 
only people with hardware documentation are myself and NVIDIA.

There is a non-working patch, if someone wants to debug it, though:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.17-nv-adma.patch.bz2

	Jeff



