Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317883AbSFNJIF>; Fri, 14 Jun 2002 05:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSFNJIE>; Fri, 14 Jun 2002 05:08:04 -0400
Received: from [212.176.239.130] ([212.176.239.130]:20497 "EHLO
	rider.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S317883AbSFNJIC>; Fri, 14 Jun 2002 05:08:02 -0400
Message-ID: <019c01c21382$bbf7a340$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10206140112490.21513-100000@master.linux-ide.org>
Subject: Re: linux 2.4.19-preX IDE bugs
Date: Fri, 14 Jun 2002 13:06:13 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Nick,
>
> http://www.tecchannel.de/hardware/817/index.html
>
> Read about the JUNK hardware base you are working with.
> This is one of the reasons people avoid VIA.

Ok. Thanks... But it's not my case. Article talks about ata-133 not
ata-100..

> OIC, it worked perfectly in wonder kernel but not in the latest.

I had 2.4.7 kernel, it was working just fine for me... Then I changed it to
2.4.18/2.4.19-preX
(with all problems I wrote about).

> Did you check to see if there were other changes in the kernel which could
> effect the behavior and operations?

It's a little bit hard for non-kernel developer to track changes between 10
kernel versions, sorry :(

> A real simple test is to undo the changes to the Promise code and does
> the problem still exist?  If it does then it is not the driver it self.

As I wrote already... I'm in process of changing hardware... and office
location.
>
> However the other changes in conjuntion could cause problems, that is a
> fair point to be made.

Sure.. But I reported problem as I've seen it in kernel logs.
>
> So how about including which kernel was the last working version.

2.4.7 Sorry, it's old enough, but usually I don't change kernel till it
works...

>
> For kicks I would back port the driver to prove it is not the driver, or
> allow you to prove it is.
>

Actually, no need to do this. As I wrote I'm changing hardware and will try
to avoid promise, via, and may be ide :)
Hope it solves the problem :) at least for me.


