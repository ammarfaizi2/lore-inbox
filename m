Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSLUXMx>; Sat, 21 Dec 2002 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLUXMx>; Sat, 21 Dec 2002 18:12:53 -0500
Received: from [209.251.112.103] ([209.251.112.103]:53770 "HELO
	icon2.iconimaging.net") by vger.kernel.org with SMTP
	id <S265211AbSLUXMw>; Sat, 21 Dec 2002 18:12:52 -0500
Date: Sat, 21 Dec 2002 17:22:47 -0600
From: Jason Radford <jradford@iconimaging.net>
To: szepe@pinerecords.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
Message-Id: <20021221172247.179b1478.jradford@iconimaging.net>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Clearly Promise is the one storage vendor whose products are best avoided.
>
>Andre, could you give a recommendation on what add-on IDE controllers are
>not junk hardware and will work nicely with Linux? 'Cos I can't seem to
>remember seeing anything in the shelves other than Promise or CMD64X/68X.

I'm no IDE RAID expert, however I've build quite a few linux servers
for customers.

If IDE raid unix linux is needed here, there's no question that a
linux supported (thanks adam) 3ware card is dropped in, no questions
asked.  For my 3 years of working with them under linux THEY JUST
WORK.  Native monitoring tools included too..

-Jason
