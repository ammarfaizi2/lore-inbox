Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVILNz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVILNz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVILNz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:55:57 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33941 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750842AbVILNz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:55:56 -0400
Message-ID: <432588E4.5020103@adaptec.com>
Date: Mon, 12 Sep 2005 09:55:48 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: luben_tulkov@adaptec.com, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com> <1126357713.3222.149.camel@laptopd505.fenrus.org>
In-Reply-To: <1126357713.3222.149.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 13:55:54.0684 (UTC) FILETIME=[B1946FC0:01C5B7A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/05 09:08, Arjan van de Ven wrote:
>>Hmm, lets see:
>>I posted today, a _complete_ solution, 1000 years ahead of this
>>"embryonic SAS class" you speak of.
> 
> 
> yet you post this without having had ANY discussion or earlier reviews
> in the recent months. IN fact to the outside world it looks like you sat
> on this code for a long time for competative reasons and just posted it
> now that Christoph is getting his layer finished.

Arjan,

Here's some details for you:

Earlier this year, I was working with
	* LSI, and
	* HP,
To create a common infrastructure for SAS Domain representation
in sysfs and common interface. (Folks who had at least
browsed the SAS spec.)  This was a volunteer effort by folks who
had some knowledge of this new techonology.  I got an email from
HP and this is how it started.

This is where the RFC posted to linux-scsi and linux-kernel came from.
Read this email posted on April 13, 2005:
http://marc.theaimsgroup.com/?t=111340592700006&r=1&w=2

This was the product of our 2 month email discussion.  It was a good
effort.

Then when I had the infrastructure ready, I sent code to that initial
list mentioned above, *and I CC-ed James* to show him what it would
look like, Christoph also got this code (via James).  This was
on July 14, 2005.  Other recipients were Jeff Garzik and Doug Gilbert.

So you see, everyone _was_ aware of what we had been doing.
 
>>So as long as *you are on their payroll*, what are you discussing here
> 
> 
> James is paid by SteelEye. Not by Dell or LSI.

He needs you to defend him?  How do you know who pays his salary?

Are you sure he's not getting hardware from LSI/Dell and
compensation to do this "embryonic SAS class" for their hardware?

Are you his accountant?
 
>>with me?  *You have an agenda*!
> 
> 
> so do you.

No, I do not.  I'm _not_ a maintainer.  I'm simply a _contributor_.
I've no agenda.  I _contribute code to the Linux kernel_ in order to
make Linux kernel a *storage enterprise OS of choice*.

If I were the _maintainer_ *and* _contributor_ *then* you can say that.

But I'm only a _contributor_, contributing to expand the areas where
Linux can be used.  This is a good thing.

	Luben

>>I long for the days of the previous maintainer.
> 
> 
> What previous maintainer?

