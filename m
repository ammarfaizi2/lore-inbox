Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRAWVaI>; Tue, 23 Jan 2001 16:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRAWV3t>; Tue, 23 Jan 2001 16:29:49 -0500
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:13828 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S130993AbRAWV3a>;
	Tue, 23 Jan 2001 16:29:30 -0500
Message-ID: <3A6DF306.DF18D0C5@bigfoot.com>
Date: Tue, 23 Jan 2001 15:09:26 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: PS/2 mouse problems in Linux 2.4.0 and 2.2.17 on KT133 chipset based 
 motherboards.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello.  I recently upgraded my workstation from an EPoX MPV3-G to a
Gigabyte 7-VX-1.  In XFree 3.3.6 the mouse cursor will randomly jump to the
upper-right hand corner of the screen and remain there until I scroll the
mousewheel.  This used to happen on the old workstation when switching
between virtual consoles and X's screen occasionally, but stopped happening
when I used X exclusively (with terminal windows).  This new behaviour has
been verified to also affect the Gigabyte 7-ZX-1 and the Asus A7V
motherboards (also based on the VIA KT133 chipset).
	Windows 2000, Windows 98, OpenBSD 2.8's PS/2 mouse handling does not appear
affected on the same chipset, nor have I ever been able to make the mouse
cursor jump to the upper-right hand corner of the screen in them.  The PS/2
mouse I am using is the Logitech M-S48.  This also affects the Microsoft
Intellimouse and other PS/2 mice without a mousewheel.

Please CC me in any followup since I do not follow the Linux-kernel mailing
list directly.
--
    www.kuro5hin.org -- technology and culture, from the trenches.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
