Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269360AbRHHJQh>; Wed, 8 Aug 2001 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270417AbRHHJQ1>; Wed, 8 Aug 2001 05:16:27 -0400
Received: from tiku.hut.fi ([130.233.228.86]:63497 "EHLO tiku.hut.fi")
	by vger.kernel.org with ESMTP id <S269360AbRHHJQL>;
	Wed, 8 Aug 2001 05:16:11 -0400
Date: Wed, 8 Aug 2001 12:16:20 +0300 (EET DST)
From: =?ISO-8859-1?Q?Janne_P=E4nk=E4l=E4?= <epankala@cc.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Via chipset
In-Reply-To: <20010807164740.U23718@work.bitmover.com>
Message-ID: <Pine.OSF.4.10.10108081211070.14566-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a reoccurring question on this (and many other) list[s].  It seems
> like someone ought to maintain a database of boards that are known to work
> and what they are used for.  For example,  lots of people say "such and such
> works for me" but what they don't say is "I only have 1 disk and 1 CDROM and
> nothing else".

I have 2 ide drives + scsi (with stuff) + sblive + nic (3c905c) + tv-card (+ usb + acpi)

abit KT7A didn't work as I hoped. (KT133A chipset) (many problems with SCSI card however 
						    I used the new aic7xxx driver)
asus a7a266 didn't work as I hoped (Ali Magick) (tv card would freeze the machine)
asus KT133-C has worked with everything just fine so far (even better). I think I have 
             1.03 (or was it 1.3) revision of the board (I can check if
             someone wants to know) (using old aic7xxx until I get #gentoo
             properly installed)

-- 
Janne
echo peufiuhu@tt.lac.nk | tr acefhiklnptu utpnlkihfeca

