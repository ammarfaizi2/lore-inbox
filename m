Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRHTXJ4>; Mon, 20 Aug 2001 19:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHTXJq>; Mon, 20 Aug 2001 19:09:46 -0400
Received: from ch-12-44-139-249.lcisp.com ([12.44.139.249]:36736 "HELO
	dual.lcisp.com") by vger.kernel.org with SMTP id <S269804AbRHTXJd>;
	Mon, 20 Aug 2001 19:09:33 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Kevin Krieser" <kkrieser_list@footballmail.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: Swap size for a machine with 2GB of memory
Date: Mon, 20 Aug 2001 18:09:38 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALCEOFFCAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <m1ofpamxv5.fsf@frodo.biederman.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just experimenting.  512MB is more than sufficient for my needs, I
just couldn't bypass the $130 (at the time) for the memory which took me to
512MB.

I've seen some later updates to the VM, but at the moment, the 2.4.8 kernel
is working well for me.  Better than the 2.4.6 kernel.

-----Original Message-----
From: eric@frodo.biederman.org [mailto:eric@frodo.biederman.org]On
Behalf Of Eric W. Biederman
Sent: Monday, August 20, 2001 12:43 PM
To: Kevin Krieser
Cc: Linux Kernel List
Subject: Re: Swap size for a machine with 2GB of memory

As long as you don't have problems where you can't run your program
multiple times in a row, 2.4 sounds like is is behaving correctly and
sanely.

> However, since my normal behavior is for swap to not be used, I will wait
a
> little bit for some of the VM updates to be tested.

Are you saying something is wrong?

> I don't have 2X RAM because when I installed my system, I only had 256MB
of
> RAM.

This is not a requirement but is a requirement to have swap > mem if
you are swapping heavily and want good performance.

Eric


