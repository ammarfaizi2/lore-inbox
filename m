Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVILN4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVILN4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVILN4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:56:53 -0400
Received: from magic.adaptec.com ([216.52.22.17]:45461 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750872AbVILN4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:56:52 -0400
Message-ID: <4325891D.2020006@adaptec.com>
Date: Mon, 12 Sep 2005 09:56:45 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com> <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 13:56:51.0154 (UTC) FILETIME=[D33D1320:01C5B7A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/05 10:30, Rik van Riel wrote:
> On Fri, 9 Sep 2005, Luben Tuikov wrote:
> 
> 
>>No self respecting SAS chip would not do 64 bit DMA, or have an sg 
>>tablesize or any other limitation.
>>
>>Naturally, aic94xx has _no limitations_. :-)  But hey, our hardware just 
>>kicks a*s!
> 
> 
> That's very nice for you - but lets face it, a SAS layer
> that'll be unable to also deal with the El-Cheapo brand
> controllers isn't going to be very useful.

Yes, I agree.  Let's take them as they come.

	Luben

