Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271163AbRHOMMN>; Wed, 15 Aug 2001 08:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271166AbRHOMMD>; Wed, 15 Aug 2001 08:12:03 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:14626 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S271163AbRHOMLu>; Wed, 15 Aug 2001 08:11:50 -0400
Message-ID: <006001c12583$70808960$fe01a8c0@federationspace.org>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Ihar Filipau" <philips@iph.to>, "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B7A4659.9B40682C@iph.to>
Subject: Re: status of VMware on 2.4?
Date: Wed, 15 Aug 2001 08:11:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello All!
>
> Could anyone say something good about VMware support of 2.4 kernel.
> I heard about problems with earlier 2.4 kernels.
>
> Any success stories?

I've been using VMware on both a Dell Inspiron 5000 and ,within the last
year, a 5000e on Linux kernels since the 2.3.99 kernels and it has worked
very well.

The earlier system was running Redhat 6.2, and the 5000e has run RH 7.0,
7.1, and most recently the roswell beta.  VMware does require some patches
to thier modules to make them compile with recent 2.4.x kernels (I think it
broke around 2.4.7).  I don't have the URL handy but it's in the lkml
archives (that's where I found them when I recently upgraded to 2.4.8-ac1).

Anyway, I've used this machine daily for over a year now, I spend about 50%
of my time in the VM running Windows 2000 Pro for compatibility with
applications at work.  It's been rock solid for me, the last serious problem
I had was trying to get the modem to work when, for some reason, Windows
2000 lost the settings for serial ports and on the next reboot decided I had
8 serial ports.   Still, this was minor, and I did get that resolved as
well.

Later,
Tom


