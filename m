Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbTCaOO7>; Mon, 31 Mar 2003 09:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbTCaOO7>; Mon, 31 Mar 2003 09:14:59 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:57238 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261649AbTCaOO6>; Mon, 31 Mar 2003 09:14:58 -0500
Message-ID: <20030331142558.1358.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: andreashappe@gmx.net
Cc: linux-kernel@vger.kernel.org
Date: Mon, 31 Mar 2003 22:25:58 +0800
Subject: Re: 2.5 on a hp omnibook 6000
X-Originating-Ip: 194.244.192.234
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andreashappe@gmx .net
>> I have a laptop, it is a HP omnibook 6000.
>mine is a hp omnibook 6100.
Ok. I think you have a bigger monitor and 
more cpu Hz.

>> http://bugzilla.kernel.org/show_bug.cgi?id=149
>that could be related to bug #18.
I don't know.
Do you have the same problem with your 6100 ?

>> http://bugzilla.kernel.org/show_bug.cgi?id=395
>works for me with compiled in maestro3 driver, could it rather be a
>distribution related problem?
Yes it could be.
But when I boot the machine I see strange lines:

Advanced Linux Sound Architecture Driver Version 0.9.0rc7 (Sat Feb 15 15:01:21 
2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
no UART detected at 0xffff
Motu MidiTimePiece on parallel port irq: 7 ioport: 0x378


> may I add some other bug reports for my laptop (hp omnibook 6100):
>computer doesn't boot with enabled acpi:
>http://bugzilla.kernel.org/show_bug.cgi?id=293
The same here, but I didn't tried with 2.5.66.

>and:
>computer doesn't shutdown with enabled apic (I thing I've heard that the
>same behaviour is shown on hp omnibook 6000).

Dunno, but I can try tomorrow.

Andreas thanks for the info,
if you want to reply please cc me, I'm not subscribed to 
the list.

Ciao,
        Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
