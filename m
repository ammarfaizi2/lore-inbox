Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSIYXZp>; Wed, 25 Sep 2002 19:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSIYXZo>; Wed, 25 Sep 2002 19:25:44 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:30725 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261208AbSIYXZn>;
	Wed, 25 Sep 2002 19:25:43 -0400
Subject: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Sep 2002 01:31:12 +0200
Message-Id: <1032996672.11642.6.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I haven't really tried a 2.5 kernel for a very long time. I used some of
the earliest, but then I suddenly had problems booting one of them, and
haven't really taken much effort in getting it boot lately.

But now I decided I should try again. I got 2.5.38 booted after some
initial trouble. But, I have a couple of weird problems. First, the
mouse. I have a Logitech Cordless Optical mouse. With kernel 2.4.x I use
MouseManPlusPS/2 as the XFree mouse-driver. Then I can use the wheel and
the fourth button just as expected. But with kernel 2.5.38 neither the
wheel or the fourth button works. I change protocol to IMPS/2 in XFree,
and everything works like expected, but the fourth button works just
like pussing the wheel (third button). This is excactly the same
behavior as with 2.4.20-pre7 (that's why I use MouseManPlusPS/2). Anyone
have a clue why this doesn't work with kernel 2.5.38?

Second problem, if I press SHIFT+PAGEUP, my computer freezes. It spits
out this message: "input: AT Set 2 keyboard on isa0060/serio0, and then
it's dead. I have a Logitech cordless keyboard. 

Anyone else experienced this?

Best regards,
Stian Jordet




