Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRIXQjq>; Mon, 24 Sep 2001 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274001AbRIXQjg>; Mon, 24 Sep 2001 12:39:36 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:6406 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S273996AbRIXQj3>; Mon, 24 Sep 2001 12:39:29 -0400
Message-Id: <200109241639.f8OGdqY90368@aslan.scsiguy.com>
To: Olaf Zaplinski <o.zaplinski@mediascape.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx errors (again) with 2.4.10pre15 
In-Reply-To: Your message of "Mon, 24 Sep 2001 18:23:58 +0200."
             <3BAF5E1E.759630A0@mediascape.de> 
Date: Mon, 24 Sep 2001 10:39:52 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Justin T. Gibbs" wrote:
>> 
>> >Hi all,
>> >
>> >my software RAID1 (hda1+sda1) worked fine with the current aic7xxx driver
>> >when using 2.4.10pre13, but with 2.4.10pre15 I get the old behaviour I know
>> >from 2.4.9:
>> 
>> What is your hardware configuration?  A full dmesg with aic7xxx=verbose
>> should be sufficient.
>
>Here it is:

I need the *full* dmesg running with the new driver and aic7xxx=verbose
set (in LILO or as an option in /etc/modules.conf if you are using an initrd).

--
Justin
