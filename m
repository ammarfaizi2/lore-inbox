Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292911AbSB0UB4>; Wed, 27 Feb 2002 15:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292920AbSB0UBf>; Wed, 27 Feb 2002 15:01:35 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:22212 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S292918AbSB0UBE>; Wed, 27 Feb 2002 15:01:04 -0500
Message-ID: <01a601c1bfc9$7a256f90$1900a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: "Rick Stevens" <rstevens@vitalstream.com>,
        "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7D3587.8080609@vitalstream.com>
Subject: Re: Big file support
Date: Wed, 27 Feb 2002 12:00:59 -0800
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

This support has been in ReiserFS for some time. On a SuSE system running
2.4.16 (their official kernel) you can issue: mkreiserfs -v2 /dev/sdaxxx and
there you go, LFS is in ver2.


Regards,

jon
----- Original Message -----
From: "Rick Stevens" <rstevens@vitalstream.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Sent: Wednesday, February 27, 2002 11:37 AM
Subject: Big file support


> I'm not certain if this is the right place, but are there plans to
> have big file support (files >2GB) anytime soon?  I ask, as we use
> Linux to serve LOTS of streaming media and the logs for popular sites
> often exceed 2GB.  I'd like to see the ability to handle at least 16GB
> files, possibly more.
>
> Please cc: me on any replies if possible.  I've been REALLY busy and
> am finding it hard to keep up with l-k traffic.
>
> Thanks!
> ----------------------------------------------------------------------
> - Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
> - 949-743-2010 (Voice)                    http://www.vitalstream.com -
> -                                                                    -
> -              Never eat anything larger than your head              -
> ----------------------------------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

