Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbTGTUHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268123AbTGTUHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:07:12 -0400
Received: from [62.67.222.139] ([62.67.222.139]:49892 "EHLO kermit")
	by vger.kernel.org with ESMTP id S268098AbTGTUHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:07:10 -0400
Date: Sun, 20 Jul 2003 22:22:00 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Weird Keyboard in 2.5.x and scheduler in 2.6.0-test1-mm1
Message-ID: <20030720202200.GA6192%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

At first my high beloved IBM PS/2 Keyboard is back on my Desk because
the Problem is kinda solved. If I disable tleds (Activity LED Simulation
on NUM and etc. LEDs of Num Keypad of the ethernet card(s))it works like
a charme on two completely different Computers. Funny I did not consider
the oftware as the Problem, but 2.5.x AND XFree86 AND this program
trigger a bug somewhere...

I read in 2.6.0-test1-mm1 and earlyer announcements that reporting of
the responsiveness of the scheduler is highly appreciated. No Version
was better than the 2.5.70-mm4 I _think_, may be I am wrong here. I
always use AS elevator and in 2.6.0-test1-mm1 typing in vim and sound
and mouse in XFree86 make pauses for 1 to 2 seconds sometimes on heavy
disk I/O. I have one 120GB IDE DISK on P2 2400 with 750MB RAM.
For exampla after an emerge world (gentoo package management) updating
portage cache makes the desktop wait for the one or other second. 

Oh, I see 2.6.0-test1-mm2 makes it way through my modem, lets see :-)

Keep on hacking,

Konsti



-- 
2.6.0-test1-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 9:18, 25 users
