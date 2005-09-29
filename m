Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVI2Q6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVI2Q6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVI2Q6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:58:41 -0400
Received: from magic.adaptec.com ([216.52.22.17]:14257 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932252AbVI2Q6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:58:39 -0400
Message-ID: <433C1D28.6080900@adaptec.com>
Date: Thu, 29 Sep 2005 12:58:16 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Bernd Petrovitsch <bernd@firmix.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>	 <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>	 <433BFB1F.2020808@adaptec.com> <1128007032.11443.77.camel@tara.firmix.at> <433C174D.4050302@adaptec.com> <433C1CD0.9080906@pobox.com>
In-Reply-To: <433C1CD0.9080906@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 16:58:25.0813 (UTC) FILETIME=[01FBDC50:01C5C517]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/05 12:56, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>On 09/29/05 11:17, Bernd Petrovitsch wrote:
>>
>>
>>>Then submit your driver as a (separate) block device in parallel to the
>>>existing SCSI subsystem. People will use it for/with other parts if it
>>
>>
>>SAS is ultimately SCSI.  I'll just have to write my own SCSI core.
>>_We_ together can do this in parallel to the old SCSI Core.
> 
> 
> You should have stated this plainly, from the start.
> 
> If you want to do your own SCSI layer, you need to do it at the block 
> layer rather than poking around drivers/scsi/

So now you are saying that I should _not_ poke at drivers/scsi?
(as I haven't done)

Are you going to make up your mind?

	Luben

