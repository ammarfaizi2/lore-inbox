Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbRDRJSs>; Wed, 18 Apr 2001 05:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133064AbRDRJS2>; Wed, 18 Apr 2001 05:18:28 -0400
Received: from denise.shiny.it ([194.20.232.1]:33996 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S133062AbRDRJSW>;
	Wed, 18 Apr 2001 05:18:22 -0400
Message-ID: <XFMail.010418111741.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010418050026.A21602@iss.dccc.edu>
Date: Wed, 18 Apr 2001 11:17:41 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Tim Peeler <tim@iss.dccc.edu>
Subject: Re: I can eject a mounted CD
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >> That's not the point. The kernel should not allow someone to
>> >> eject a mounted media.
>> >
>> > rpm -e magicdev
>>
>> Magicdev is not installed.
>> Ok, I'm the only one with this problem, I'll manage to find the bug by myself.
>
> eject(1) line 36:
>
>    If the device is currently mounted, it is unmounted before
>    ejecting.

But it doesn't get unmounted. I eject the disk but I can still see
and read the (cached) files !


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

