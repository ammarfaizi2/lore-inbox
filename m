Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280750AbRKJW4I>; Sat, 10 Nov 2001 17:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280751AbRKJWzt>; Sat, 10 Nov 2001 17:55:49 -0500
Received: from mailin10.bigpond.com ([139.134.6.87]:57074 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S280750AbRKJWzr>; Sat, 10 Nov 2001 17:55:47 -0500
Message-ID: <000001c16a3b$76fb25f0$1401a8c0@vaio>
From: "Robert Lowery" <cangela@bigpond.net.au>
To: <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Assertion failure wth ext3 on standard Redhat 7.2 kernel
Date: Sat, 10 Nov 2001 22:57:19 +1100
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

This problem has gone away now that I have removed the extra 64M RAM that I
added recently.

Funny that memtest86 did not pick up any problems.  Must be stray gamma rays
;)

Thanks

-Robert
----- Original Message -----
From: "Robert Lowery" <cangela@bigpond.net.au>
To: <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, November 09, 2001 10:45 PM
Subject: Re: Assertion failure wth ext3 on standard Redhat 7.2 kernel


> > >It looks like memory corruption of some form - a structure
> > >member has an impossible value. Are you using any less-than-mainstream
> > >device drivers in that box?
> P.S. The problem occurs on a completely virgin Redhat 7.2 install as well
as
> after I have applied all available updates. (after a few crashes and
reboots
> while applying them).
>
> -Robert
>

