Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTA1Vt3>; Tue, 28 Jan 2003 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTA1Vt3>; Tue, 28 Jan 2003 16:49:29 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6408 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261448AbTA1Vt2>;
	Tue, 28 Jan 2003 16:49:28 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301282159.h0SLxPk7003050@darkstar.example.net>
Subject: Re: Bootscreen
To: b_adlakha@softhome.net (Balram Adlakha)
Date: Tue, 28 Jan 2003 21:59:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301290318.20817.b_adlakha@softhome.net> from "Balram Adlakha" at Jan 29, 2003 03:18:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> though i have recently subscribed to this list (OMG, 30 mails/hour!), I've 
> read the whole thread about this bootscreen thing... I see absolutely _no_ 
> reason why it should not be included in the kernel configuration, since there 
> are patches available already to make it work, and there are already soo many 
> useless options that adding another won't make a difference...

Many old options are also removed, though.

> I don't think adding the option to the kernel configuration would do any 
> harm...exept that the kernel source may get enlarged by (200 kb?), and the 
> kernel source gets enlarged every day anyway... 2.5 is HUGE compared to 
> 2.2...

That's partly because it's a development tree.  There are big efforts
to trim it down as much as possible.

I don't see any real advantage to putting in to the mainstream kernel
something which can be achieved easily with a custom bootloader, and
kernel options.

John.
