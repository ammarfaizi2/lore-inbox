Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278041AbRJIWmp>; Tue, 9 Oct 2001 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278040AbRJIWmg>; Tue, 9 Oct 2001 18:42:36 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:16847 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S278037AbRJIWmS>; Tue, 9 Oct 2001 18:42:18 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
Date: Wed, 10 Oct 2001 00:41:50 +0200
X-Mailer: KMail [version 1.3.1]
Cc: "Paul G. Allen" <pgallen@randomlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011009224227Z278037-761+17507@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. Oktober 2001 23:16 schrieb Dieter Nützel:
> Has anybody some numbers, yet?
>
> Thanks,
> 	Dieter

Here comes what I've found so far fro single Athlon XP on Linux.

http://www.linuxhardware.org/features/01/10/09/1514233.shtml

Summary and thanks for your fast replies:

All Athlons/Durons except the first SlotA ones (Athlon I; 0,25 µm; no apic; 
no available boards) support SMP. I know it before from the docs...;-)

But "only" the "latest" Athlon MP/XP (Palomino core) and Duron (Morgan core, 
based on the Palomino core) support it "very" well. This is due to the 
enhanced TLBs and cache redesign.
Only difference between Athlon MP vs XP is that the first is "validate" for 
SMP.

So any dual numbers? I know that Paul G. Allen would upgrade his Tyan Thunder 
K7 dual 1.4 GHz TB Athlon to an dual Athlon XP.

Greetings,
	Dieter

