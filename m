Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262761AbSJGXyv>; Mon, 7 Oct 2002 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJGXyv>; Mon, 7 Oct 2002 19:54:51 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:50049 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262761AbSJGXyu> convert rfc822-to-8bit; Mon, 7 Oct 2002 19:54:50 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Blinking Keyboard LED after crash?
Date: Tue, 8 Oct 2002 02:00:03 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210080200.03756.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have had some total crashes on my box without any output to console. The 
kernel just started to blink CapsLock and ScrollLock LEDs.

I wasn't able to find any documentation to these error-codes.

I'm using 2.4.19 on an i386 architecture:

CPU: K5PR166
Chipset: PIIX3

I will post more information, if needed.

I just found out that I use the wrong gcc-version 2.95.2 instead of 2.95.3, so 
the error will perhaps go away after recompilation.

But I'm still curious about these errorcodes.

Thanks in advance
 Jan-Hinnerk

