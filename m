Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277219AbRJLEpr>; Fri, 12 Oct 2001 00:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277220AbRJLEpg>; Fri, 12 Oct 2001 00:45:36 -0400
Received: from oe51.law9.hotmail.com ([64.4.8.40]:25860 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277219AbRJLEpU>;
	Fri, 12 Oct 2001 00:45:20 -0400
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
        "Mark Atwood" <mra@pobox.com>
In-Reply-To: <m38zehucml.fsf@flash.localdomain>
Subject: Re: Module read a file?
Date: Fri, 12 Oct 2001 00:43:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE51xcbz37cfJiY9ZNM0000e151@hotmail.com>
X-OriginalArrivalTime: 12 Oct 2001 04:45:46.0791 (UTC) FILETIME=[C2376B70:01C152D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the PSS sound driver code.  In either 2.2.x or 2.4.x.  It allows you
to load a firmware from a selected file.

----- Original Message -----
From: "Mark Atwood" <mra@pobox.com>
To: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
Sent: Thursday, October 11, 2001 4:48 PM
Subject: Module read a file?


> I'm modifying a PCMCIA driver module so that it can load new firmware
> into the card when it's inserted.
>
> Rather than including the firmware inside the module's binary, I would
> much rather be able to read it out of the filesystem.
>
> Are their any good examples of kernel code or kernel modules reading a
> file out of the filesystem that I could copy or at least look to for
> inspiration?
>
> --
> Mark Atwood   | I'm wearing black only until I find something darker.
> mra@pobox.com | http://www.pobox.com/~mra
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
