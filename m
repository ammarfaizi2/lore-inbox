Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273750AbRIQXMf>; Mon, 17 Sep 2001 19:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273749AbRIQXMZ>; Mon, 17 Sep 2001 19:12:25 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:49316 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S273750AbRIQXMN>; Mon, 17 Sep 2001 19:12:13 -0400
From: Sam Varshavchik <mrsam@courier-mta.com>
To: Joseph Cheek <joseph@cheek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disregard: Re: ide zip 100 won't mount
Date: Mon, 17 Sep 2001 19:12:34 -0400
X-Mailer: Oak 0.01
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BA68362.00004D02@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Cheek writes: 

> hmm, i went into windows *one more time* just to make sure it was still 
> working, and not a hardware problem.  well... looks like it doesn't work 
> in windows either.  must be hardware. 
> 
> funny thing it shows up in dmesg and in "My Computer", just can't read 
> from it.

That's pretty much what the sense codes below did indicate - media problem.  
Try a different disk. 

> 
> Joseph Cheek wrote: 
> 
>> i've tried 2.4.7-ac10 and 2.4.9-ac10.  same results.  at boot i get: 
>> 
>> Sep 17 11:02:48 seattle kernel: ide-floppy driver 0.97.sv
>> Sep 17 11:02:48 seattle kernel: hdd: No disk in drive
>> Sep 17 11:02:48 seattle kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 
>> 512
>> sector size, 2941 rpm 
>> 
>> looks good, right?  but i put a disk in and i get: 
>> 
>> Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc =  0, key 
>> =
>> 2, asc = 30, ascq =  0
>> Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc = 1b, key 
>> =
>> 2, asc = 30, ascq =  0
>> Sep 17 14:36:23 seattle kernel: hdd: No disk in drive 
>> 
>> not hardware, as it works in windows on the same machine. 
>> 
>> any ideas? 
>> 
>> thanks!

-- 
Sam
