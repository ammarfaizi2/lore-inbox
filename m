Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSFIRcl>; Sun, 9 Jun 2002 13:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSFIRck>; Sun, 9 Jun 2002 13:32:40 -0400
Received: from inje.iskon.hr ([213.191.128.16]:26876 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S314077AbSFIRcj>;
	Sun, 9 Jun 2002 13:32:39 -0400
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.21 failure: ata_taskfile: unknown command 78
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, 09 Jun 2002 19:32:23 +0200
Message-ID: <87y9dos6hk.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an endless stream of that messages in 2.5.21 (2.5.20 was
OK). I have a VIA motherboad with 686B southbridge and add-on Promise
20268 card.

What else can I do to help find the bug?
-- 
Zlatko
