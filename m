Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274223AbRISWO3>; Wed, 19 Sep 2001 18:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274222AbRISWOT>; Wed, 19 Sep 2001 18:14:19 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:1200 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S274220AbRISWOH>; Wed, 19 Sep 2001 18:14:07 -0400
In-Reply-To: <fa.ia34bav.ijiuqq@ifi.uio.no>
            <fa.jbpet1v.q08fo6@ifi.uio.no>
In-Reply-To: <fa.jbpet1v.q08fo6@ifi.uio.no> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: "Mark H. Wood" <mwood@IUPUI.Edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disregard: Re: ide zip 100 won't mount
Date: Wed, 19 Sep 2001 22:14:29 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BA918C5.00006F91@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark H. Wood writes: 

> On Mon, 17 Sep 2001, Sam Varshavchik wrote: 
>
>> That's pretty much what the sense codes below did indicate - media problem.
> 
> For future reference, is there any sort of tool that will decode these
> magic numbers, since the driver doesn't do it for us?  It ought to cut
> down on the number of posts beginning, "my IDE driver began speaking in
> tongues, what is it trying to tell me?"

ftp://ftp.seagate.com/sff/INF-8070.PDF 

You'll have to page through it, it's kind of scattered all over the place. 

This is for removable ATAPI IDE devices.  I don't know how much of that is 
applicable to plain garden-variety IDE devices. 

-- 
Sam 

