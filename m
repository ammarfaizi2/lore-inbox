Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbRFEMvQ>; Tue, 5 Jun 2001 08:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRFEMvG>; Tue, 5 Jun 2001 08:51:06 -0400
Received: from smtp3.vol.cz ([195.250.128.83]:31762 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S261628AbRFEMux>;
	Tue, 5 Jun 2001 08:50:53 -0400
Message-ID: <3B1CD5AB.3481E16B@volny.cz>
Date: Tue, 05 Jun 2001 14:50:51 +0200
From: Tomas Franke <tomas.f@volny.cz>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Trident 9660 problem
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have following problem:
I have an old Olivetti computer as the router. After I upgraded it to 2.4.2
kernel (RedHat 7.1), the screen always blanks in the moment when it starts to
write the boot messages. The screen is completely black and no signal on
Hsync/Vsync on VGA conncetor. So the monitor goes to the sleep mode after a
while.
But the rest of the computer works as usual during this problem. Only the video
output is disabled.
I tried several vga= options but with the same result. The video chip is
reported as "Trident 9660" by both X Windows and M$ Windoze.

Is this problem known?


Tomas
