Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265948AbRFZI3n>; Tue, 26 Jun 2001 04:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265950AbRFZI3d>; Tue, 26 Jun 2001 04:29:33 -0400
Received: from mail.n-online.net ([195.30.220.100]:25356 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S265948AbRFZI3S> convert rfc822-to-8bit; Tue, 26 Jun 2001 04:29:18 -0400
Date: Tue, 26 Jun 2001 10:26:26 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Re: AMD thunderbird oops
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <20010626082928Z265948-17720+7692@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> as i've said before - i have the same problem too

Me too

> the memory is OK! - have run memtest86 for hours ... - no errors ... -
> heatsink - CPU@45°C - Case @ 25°C

> after changing the kernel compile to PentiumII (nearly) everything worked
> fine ....

I HAD a Asus K7M with a 650 MHz Athlon, 256 MB RAM (Infineon, Ram is OK).
Using 2.4.2 AND 2.4.4 didn't work.
Whenever i started KDE2, the crashes startet, even oopses in ext2-code appeared.

The strange thing is : If i startet KDE2 as root, the crashes didn't happen!

I don't know why, my distribution is RedHat 7.1

Now i have a Epox 8kta3+ with an 1,333 MHz Athlon, FSB266, 256 MB RAM (Infineon)
and the crashes still appear.

Changing the Kernel from Athlon to Pentium-II/III makes the system stable again.

Thomas

