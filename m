Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbRBLIxo>; Mon, 12 Feb 2001 03:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbRBLIxe>; Mon, 12 Feb 2001 03:53:34 -0500
Received: from [195.154.83.81] ([195.154.83.81]:39686 "EHLO netgem.com")
	by vger.kernel.org with ESMTP id <S129234AbRBLIxV>;
	Mon, 12 Feb 2001 03:53:21 -0500
From: Jocelyn Mayer <jocelyn.mayer@netgem.com>
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Message-ID: <3A87A453.8050802@netgem.com>
Date: Mon, 12 Feb 2001 09:52:35 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010119
X-Accept-Language: en, fr
MIME-Version: 1.0
Subject: Re: FA-311 / Natsemi problems with 2.4.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/>>  /
/>> I found something from OpenBSD: /
/>> the natsemi chip (in fact DP83815) /
/>> is quite the same as SiS900 one. /

 > If that is true, maybe you can hack drivers/net/sis900.c to get it to
 > work with the FA-311?

 >       Jeff

First of all, I'm sorry to be so late to answer,
but we had problems with our mail server, last week (damned NT.....) :=(((

I know that some (maybe a lot..) of the FA311 cards work well with the 
natsemi driver.
I know that some doesn't work, also. In fact, I don't use a FA311 card,
but a DP83815 Chip included on a motherboard.
And, in my case, the driver fails....

I started to work on the SiS900 driver.
I will try to do something about it...
Maybe it won't be quick,
because I'm not used to work so deep inside the kernel,
but it's a good time to start ! :=)))

So, please be patient, I'll come back with something new,
one of these days...

Jocelyn Mayer.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
