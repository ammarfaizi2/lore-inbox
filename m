Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129902AbRA3PP4>; Tue, 30 Jan 2001 10:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130996AbRA3PPh>; Tue, 30 Jan 2001 10:15:37 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:11934 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S130671AbRA3PPa>;
	Tue, 30 Jan 2001 10:15:30 -0500
Message-ID: <003001c08acf$7ae475f0$9b2f4189@angelw2k>
From: "Micah Gorrell" <angelcode@myrealbox.com>
To: "Andrey Savochkin" <saw@saw.sw.com.sg>
Cc: "Romain Kang" <romain@kzsu.stanford.edu>, <linux-kernel@vger.kernel.org>,
        <root@chaos.analogic.com>, "Craig I. Hagan" <hagan@cih.com>
Subject: Re: eepro100 - Linux vs. FreeBSD
Date: Tue, 30 Jan 2001 08:15:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been running 2.2 on many machines since its release and have updated
to the latest version of 2.2 many times.  All of these machines have an
eepro100 and I never saw a single problem with any of them.  I updated most
of my machines to 2.4 over the course of a week and within a day of updating
each of them showed the problem.  This may be pure chance but it sounds to
me as if it is a difference with the 2.4 kernel.

Micah
___
The irony is that Bill Gates claims to be making a stable operating system
and Linus Torvalds claims to be trying to take over the world
-----Original Message-----
From: "Andrey Savochkin" <saw@saw.sw.com.sg>
To: "Micah Gorrell" <angelcode@myrealbox.com>
Cc: "Romain Kang" <romain@kzsu.stanford.edu>;
<linux-kernel@vger.kernel.org>; <root@chaos.analogic.com>; "Craig I. Hagan"
<hagan@cih.com>
Date: Tuesday, January 30, 2001 12:35 AM
Subject: Re: eepro100 - Linux vs. FreeBSD


>On Mon, Jan 29, 2001 at 11:06:11AM -0700, Micah Gorrell wrote:
>> As stated in a number of previous messages to this list many people have
had
>> serious problems with the eepro100 driver in 2.4.  These problems where
not
>> there in 2.2 and it is not a select few machines showing this so I very
much
>> doubt that it is a configuration problem.  I assume that the intel driver
>> would prolly fix all of these issues but its not ready for 2.4 yet and
its
>[snip]
>
>In the first place, the "no resource" problem is a hardware one.
>As far as I understand, it's a buggy (or undocumented) timing requirement
>for some revisions.
>This problem showed with any kernel, 2.2 or 2.4, until a workaround was
>developed.  On a single computer suffering from that problem it showed not
on
>every boot, but about in 30 percents.  That's why the reports were
different.
>So, the kernel version is irrelevant to this problem.
>
>Best regards
> Andrey V.
> Savochkin
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
