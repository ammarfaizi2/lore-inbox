Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbQLMSRd>; Wed, 13 Dec 2000 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLMSRN>; Wed, 13 Dec 2000 13:17:13 -0500
Received: from cambot.suite224.net ([209.176.64.2]:56842 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S129585AbQLMSQ4>;
	Wed, 13 Dec 2000 13:16:56 -0500
Message-ID: <000a01c0652d$26088480$f342b0d1@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "Gregoire Favre" <greg@ulima.unil.ch>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3A374622.7167CA22@ulima.unil.ch>
Subject: Re: DVD on Linux
Date: Wed, 13 Dec 2000 12:49:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: Gregoire Favre <greg@ulima.unil.ch>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 13, 2000 4:49 AM
Subject: Re: DVD on Linux


> zink wrote:
>
> >  The final 2.2.18 is out - I didn't see UDF option under filesystems,
altough it should
> > have been there - maybe we'll wait (for ages) untilfinal 2.4 is out.
>
> I haven't used 2.2 for ages, but as far as I remember, you could just use
iso9660 for DVD...
> (Well since 2.2.n with n great enough...).
>
> Greg

Guys,
Is the code in the source for 2.2.18? If it is, then check the config.in
file in the fs/ dir for a commented block (like for usb). Unless it's been
folded into the iso9660 driver...

Matthew D. Pitts
mpitt@suite224.net


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
