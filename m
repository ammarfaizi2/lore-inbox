Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWCGANg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWCGANg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWCGANg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:13:36 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49480 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751611AbWCGANf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:13:35 -0500
Date: Mon, 06 Mar 2006 18:15:22 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
In-reply-to: <5MyAS-5zh-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <440CD09A.9040005@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <5Mq18-1Na-21@gated-at.bofh.it> <5MqNc-2Y5-3@gated-at.bofh.it>
 <5MqX4-39H-21@gated-at.bofh.it> <5MyAS-5zh-5@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Monnerie wrote:
> On Freitag, 3. März 2006 23:23 Jeff Garzik wrote:
>> I'll happen but not soon.  Motivation is low at NV and here as well,
>> since newer NV is AHCI.  The code in question, "NV ADMA", is
>> essentially legacy at this point -- though I certainly acknowledge
>> the large current installed base.  Just being honest about the
>> current state of things...
> 
> I'd like to raise motivation a lot because most MB sold here (central 
> Europe) are Nforce4 with Athlon64x2 at the moment. It would be nice 
> from vendors if they support OSS developers more, as it's their 
> interest to have good drivers.

I second that.. It appears that nForce4 will continue to be a popular 
chipset even after the Socket AM2 chips are released, so the demand for 
this (and for NCQ support as well, likely) will only increase.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

