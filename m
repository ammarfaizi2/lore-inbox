Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314334AbSDRPiO>; Thu, 18 Apr 2002 11:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314347AbSDRPiN>; Thu, 18 Apr 2002 11:38:13 -0400
Received: from [213.250.49.39] ([213.250.49.39]:61316 "EHLO godzila.nuedi.com")
	by vger.kernel.org with ESMTP id <S314334AbSDRPiN>;
	Thu, 18 Apr 2002 11:38:13 -0400
Message-ID: <025e01c1e6ef$03600080$0201a8c0@nuedi.com>
From: "Vasja J Zupan" <vasja@nuedi.com>
To: "Andy Jeffries" <lkml@andyjeffries.co.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <001d01c1e6e3$c2ef1e60$b4a6a8c0@si> <20020418161217.5bcccbb2.lkml@andyjeffries.co.uk>
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server
Date: Thu, 18 Apr 2002 17:37:56 +0200
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

Thanks!!!!
Can you tell me if it was crashing only if raid controller was used, or did
it crash on normal ide too?
I could wait until stable kernel is out, living only with software raid and
use HW afterwards. or use your patch of course!

Does this motherboard have any other (Linux or any other) performance and
stability issues?

Rgds,
Vasja

----- Original Message -----
From: "Andy Jeffries" <lkml@andyjeffries.co.uk>
To: "Vasja J Zupan" <vasja@nuedi.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 18, 2002 5:12 PM
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server


> On Thu, 18 Apr 2002 16:16:47 +0200, "Vasja J Zupan" <vasja@nuedi.com>
> wrote:
> > Hi,
> > I'm buying a production server for webservices for mobile operators.
> >
> > My HW provider suggested Abit's KR7A-133R (ATA133)  with HPT372.
> >
> > Is this motherboard already fully supported and when will stable kernel
> > be ready for production use on these motherboards? (btw - any advice on
> > good amd combo is appreciated)
> >
> > Thank you for your help and I'd appreciate a personal cc: cos I'm not a
> > member of this list.
>
> It was crashing the Kernel, I helped a friend get his working with a patch
> which he has uploaded on his website.  To date, I haven't had a reply when
> I tried to ask who to submit it to on here (2.4.18 isn't fixed AFAIK).
>
> http://www.timj.co.uk/linux/
>
> Cheers,
>
>
>
>
> --
> Andy Jeffries
> Linux/PHP Programmer
> http://www.andyjeffries.co.uk/
>
> - Windows Crash HOWTO: compile the code below in VC++ and run it!
> main (){for(;;){printf("Hung up\t\b\b\b\b\b\b");}}
>

