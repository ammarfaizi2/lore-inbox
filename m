Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbRE0TJq>; Sun, 27 May 2001 15:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbRE0TJg>; Sun, 27 May 2001 15:09:36 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:12809 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S261490AbRE0TJT>; Sun, 27 May 2001 15:09:19 -0400
Message-ID: <3B1150DB.ADF2178A@bluewin.ch>
Date: Sun, 27 May 2001 21:09:16 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Console display in portrait mode with unusual dpi resolution
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overview: At business I just got a brand new EIZO 18" LCD display L675
to test its usability for working in portrait mode to show a full A4
page. These test were done on Windows NT4 but I'd really like to know
how well Linux would have done. I'm going to describe all the obstacles
I encountered on Windows so anybody may knows the corresponding answers
for Linux. Maybe there are other problems on Linux?

1. Obstacle
While the EIZO L675 is mechanically turnable, it doesn't handle the
landscape/portrait mode switch itself. [OFFTOPIC] Are the any other
displays capable of this? [OFFTOPIC OFF] The turning software had to be
ordered/paid separate (Pivot software). Of course the display should
handle it itself, but until this happens a software solution is okay. Is
there any software solution for Linux?
I've heard there are graphics cards which handles the landscape/portrait
mode themselves (i.e. ATI radeon). This is almost as good as if the
display handles it, as long as if there are the corresponding drivers
available. How about Linux drivers?
PS. My good old monochrome portrait monitor from Apple (around 1990) is
an fine example.

2. Obstacle
The portrait mode software starts working just about before the logon
screen is shown. All the BIOS and system messages are shown in landscape
mode. This looks funny but is acceptable as long as no user interaction
is necessary. So i.e. it needs a rather high concentration to switch to
another hardware profile (Windows NT4). From the nature of a software
solution I guess this can't be changed neither of Windows NT4 nor Linux.

3. Obstacle
The EIZO L675 has a pixel pitch of 0.28x0.28 which is equivalent to
about 90dpi. Since Windows (any version) uses a default value on 96dpi,
everything is enlarged by about 5%. So even with an 18" display an A4
page can't be normally viewed in Word. Current status from Microsoft
"problem is recognized, we are working on it". While there is no
solution for Windows (probably until SP1 for XP) what's the status of
Linux? 
PS. My good old monochrome portrait monitor is again an example. While
it has 80dpi and Apple defaults to 72dpi on these old monitors (10%
decrease) and Macintosh typically there is no useless scrap around, I
can view an A4 page. Of course it also shows that even Apple has no
solution to the dpi problem.

O. Wyss
