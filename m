Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131168AbRCGUJo>; Wed, 7 Mar 2001 15:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131179AbRCGUJe>; Wed, 7 Mar 2001 15:09:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39949 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131168AbRCGUJS>;
	Wed, 7 Mar 2001 15:09:18 -0500
Date: Wed, 7 Mar 2001 21:08:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
Message-ID: <20010307210848.E4653@suse.de>
In-Reply-To: <Pine.GSO.4.30.0103072059180.29959-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0103072059180.29959-100000@balu>; from pozsy@sch.bme.hu on Wed, Mar 07, 2001 at 09:03:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07 2001, Pozsar Balazs wrote:
> 
> hi all,
> 
> Whatever I tried, I couldn't get my DVDs read. I get:
>  sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> or, I don't use ide-scsi, i get the ATAPI equivalent.
> I have udf support compiled in, i have successfully authenticated the
> disk(s), but lo luck.
> 
> The drive is:
>    Vendor: PIONEER   Model: DVD-ROM DVD-105   Rev: 1.22
> 
> I tried 2.2.17, 2.4.1 & 2.4.2 (and a few different compiled versions of
> them)
> 
> What might be the problem?

I don't know, you provide virtually no information. Use the ATAPI
driver, and dump dmesg info when this happens. Then send that along.

-- 
Jens Axboe

