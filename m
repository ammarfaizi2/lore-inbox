Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbRL2FRY>; Sat, 29 Dec 2001 00:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287140AbRL2FRO>; Sat, 29 Dec 2001 00:17:14 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:18888 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287139AbRL2FRF>; Sat, 29 Dec 2001 00:17:05 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
Date: Sat, 29 Dec 2001 06:16:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011229051712Z287139-18284+8656@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide worte:
> There's a bug fix and the use of the Time Slice Split Scheduler inside the
> local CPUs schedulers. Versions from 0.46 to 0.52 are broken by the fixed
> bug so testers should use this version :
>
> http://www.xmailserver.org/linux-patches/mss-2.html#patches

Sorry, if someone asks this before but do you think that you get some stuff 
out of it for 2.4.xx?

Your numbers for the 8 SMP system are great.
Can't wait to do some tests on my poor single 1 GHz Athlon II and soon dual 
Athlon MP/XP 1600+ on an MS 6501 (AMD 760MPX).

Maybe my MP3/Ogg-Vorbis hiccup during dbench 32+ are solved?
Currently running latest 2.4.17+preempt (do think that can be mixed with your 
new scheduler?).

Thanks,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
