Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRJ1Urm>; Sun, 28 Oct 2001 15:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278668AbRJ1Urd>; Sun, 28 Oct 2001 15:47:33 -0500
Received: from oe49.law11.hotmail.com ([64.4.16.21]:2323 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S278665AbRJ1UrW>;
	Sun, 28 Oct 2001 15:47:22 -0500
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: "David Flynn" <Dave@keston.u-net.com>,
        "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
In-Reply-To: <045301c15fa7$c2809b70$1901a8c0@node0.idium.eu.org>
Subject: Re: Via KT133 and 2.4.8 and a hard disk problem ?
Date: Sun, 28 Oct 2001 12:46:36 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE499R5FyGYPyZ0R7HL00016c26@hotmail.com>
X-OriginalArrivalTime: 28 Oct 2001 20:47:53.0718 (UTC) FILETIME=[D0C17160:01C15FF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had these problems before.  Can you provide a listings of the kernel
errors you are getting?  I'm curious myself, and I'm sure this would help
any developers as well.  Also, is it an old KT133 (with vt82c686a chip) or
KT133A (with vt82c686b chip).

----- Original Message -----
From: "David Flynn" <Dave@keston.u-net.com>
To: "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
Sent: Sunday, October 28, 2001 3:57 AM
Subject: Via KT133 and 2.4.8 and a hard disk problem ?


> All;
>
> What is the status of the problems with the old KT133 and kernel 2.4.8 ?
>
> I have a system here which looks to me as if its beginning to suffer from
> HDD failure, just do anything with the disk for a while and you get disk {
> busy } errors (and there is an 0x0d error code there somewhere) ... (oh,
and
> the HDD light reports no activity) normally, i would view this as a good
> time to pull all the data off the drive and replace it.
>
> However, i have noticed that the chipset used is the Via KT133, and am now
> wondering if this is actually a HDD problem (i still am siding with this)
or
> a chipset problem.
>
> You can guarantee the problem by just running badblocks -sv /dev/hda
>
> and it will happen at some point, (not always the same place)
>
> Can anyone offer any advice on this ?
>
> Thanks,
>
> Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
