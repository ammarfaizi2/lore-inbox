Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265411AbRGEPiv>; Thu, 5 Jul 2001 11:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265421AbRGEPil>; Thu, 5 Jul 2001 11:38:41 -0400
Received: from foobar.isg.de ([62.96.243.63]:27409 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S265411AbRGEPid>;
	Thu, 5 Jul 2001 11:38:33 -0400
Message-ID: <3B4489F2.125219E7@isg.de>
Date: Thu, 05 Jul 2001 17:38:26 +0200
From: Constantin Loizides <Constantin.Loizides@isg.de>
Organization: Innovative Software AG
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom spaziani <digiphaze@deming-os.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Module tracing.
In-Reply-To: <3B3CF50E.65D24882@deming-os.org> <0107032136310A.00338@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want this.  I've been thinking about it since your original post, and
I also would be very much interested in having such a great
tool by hand.
Please mail me any information, or code to try, thanx!

> 
> Perhaps you should also think about a non-devfs way of doing this, I don't
> know, it's a matter of taste.  Here's a Rube Goldbergesque way: when the
> client registers, export a dynamically allocated major number through proc
> and let the user mknod a device with that major.

Yes I think, that would be a great alternative, using good old /proc.

Constantin
