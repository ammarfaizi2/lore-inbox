Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbRFUTEA>; Thu, 21 Jun 2001 15:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265116AbRFUTDu>; Thu, 21 Jun 2001 15:03:50 -0400
Received: from isimail.interactivesi.com ([207.8.4.3]:9994 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S265111AbRFUTDk>; Thu, 21 Jun 2001 15:03:40 -0400
Date: Thu, 21 Jun 2001 14:03:32 -0500
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <993153729.7844.3.camel@Monet>
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com> <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com>
Subject: Re: Controversy over dynamic linking -- how to end the panic
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <Y0SvmB.A.0g.FUkM7@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Wei Weng <wweng@kencast.com> on 21 Jun 2001 16:01:58
-0400


> Hell, why does the linux community need to care about other *greedy*
> people who don't want to GPL their work anyway? If you want to protect
> GPL as the principle in Linux, well, screw the device driver makers!

Unfortunately, your position will result in reduce hardware support.  There are
companies out there that will not release the source code to their drivers.  By
preventing binary-only drivers, you're basically telling those companies, "I
don't care who needs your hardware to work under Linux, I won't let you ship
your drivers." 

Besides, your opinion on this matter is irrelevant.  Linus has already decided
to allow binary-only drivers.  The question is not WHETHER it is allowed, but
HOW it will be allowed.  Please stay on topic.

> What is the difference between including kernel header file and
> including GPLed header file?

None, as far as I know, and that's the problem.  By Linus saying, "including
kernel header files doesn't make your driver a derivative work", he is
effectively _weakening_ a provision in the GPL _as a whole_ (assuming that you
believe including header files makes your work a derivative, which I don't).


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

