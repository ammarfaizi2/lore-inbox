Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264383AbRFNB3S>; Wed, 13 Jun 2001 21:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264385AbRFNB3I>; Wed, 13 Jun 2001 21:29:08 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:53154 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S264383AbRFNB26>;
	Wed, 13 Jun 2001 21:28:58 -0400
Date: Thu, 14 Jun 2001 02:31:35 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200106140231.f5E2VYG25767@beast.stev.org>
To: ddickman@nyc.rr.com
CC: linux-kernel@vger.kernel.org
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

>-- a simpler, cleaner kernel will also be of more use in an academic
>environment.

>i386, i486
>The Pentium processor has been around since 1995. Support for these older
>processors should go so we can focus on optimizations for the pentium and
>better processors.

>ISA bus, MCA bus, EISA bus
>PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
>CONFIG_ISAPNP, etc
>
>ISA, MCA, EISA device drivers
>If support for the buses is gone, there's no point in supporting devices for
>these buses.

i use all of the above and also require some of the new feature though you 
say good for academic in the UK most of the places are still running 486's 
as workstations when they come to though them out soon you wanna at least 
let the run a linux course with them first :)

>parallel/serial/game ports
>More controversial to remove this, since they are *still* in pretty wide
>use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.

these are possible in greater usage than you think. isdn cards still look 
like serial ports etc... scanner and where do you plug a joy stick in i 
have never even seen a usb joystick. hey i dont even have USB ports.

though i do agree that there is alot of stuff there but its still mostly 
drivers.

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  2:20am  up 14:45,  6 users,  load average: 0.10, 0.18, 0.42
