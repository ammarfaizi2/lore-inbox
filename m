Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbRDRH1E>; Wed, 18 Apr 2001 03:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133048AbRDRH0y>; Wed, 18 Apr 2001 03:26:54 -0400
Received: from denise.shiny.it ([194.20.232.1]:30154 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S133047AbRDRH0g>;
	Wed, 18 Apr 2001 03:26:36 -0400
Message-ID: <XFMail.010418092543.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E14pcR4-0003E2-00@the-village.bc.nu>
Date: Wed, 18 Apr 2001 09:25:43 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: I can eject a mounted CD
Cc: lna@bigfoot.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > /dev/cdrom        /mnt/cdrom        auto        noauto,user,ro    0 0
>> >
>> > And remove the other cdrom listing. This will allow mounting any
>> > supported format and eliminate the duel support for one device.
>>
>> That's not the point. The kernel should not allow someone to
>> eject a mounted media.
>
> rpm -e magicdev

Magicdev is not installed.
Ok, I'm the only one with this problem, I'll manage to find the bug by myself.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

