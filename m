Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWJETQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWJETQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWJETQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:16:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57216 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750731AbWJETQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:16:26 -0400
Message-ID: <45255A02.2010308@garzik.org>
Date: Thu, 05 Oct 2006 15:16:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi updates for post 2.6.18
References: <1159995678.3437.80.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.60.0610052104330.6619@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0610052104330.6619@poirot.grange>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Wed, 4 Oct 2006, James Bottomley wrote:
> 
>> This is (hopefully) my final batch of updates before we go -rc1.  It's
>> mainly code cleanups, some driver updates and the new qla4xxx iScsi
>> driver.
> 
> James, is there a reason why you didn't include this one:
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=115974328128341&w=2
> 
> Do you think it can cause problems?

It would be nice to get it tested, based on your "don't know if it works 
though" comment...

	Jeff



