Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSELTTd>; Sun, 12 May 2002 15:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315380AbSELTTd>; Sun, 12 May 2002 15:19:33 -0400
Received: from inje.iskon.hr ([213.191.128.16]:1708 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S315379AbSELTTc>;
	Sun, 12 May 2002 15:19:32 -0400
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pdc202xx.c fails to compile in 2.5.15
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, 12 May 2002 21:19:22 +0200
In-Reply-To: <3CDD4DE5.5030200@evision-ventures.com> (Martin Dalecki's
 message of "Sat, 11 May 2002 18:59:17 +0200")
Message-ID: <877km99nt1.fsf_-_@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pdc202xx.x fails to compile in 2.5.15. Error messages below.


pdc202xx.c:1453: unknown field `exnablebits' specified in initializer
pdc202xx.c:1453: warning: braces around scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: braces around scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: initialization makes pointer from integer without a cast
pdc202xx.c:1453: warning: excess elements in scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: excess elements in scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: braces around scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: initialization makes pointer from integer without a cast
pdc202xx.c:1453: warning: excess elements in scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: excess elements in scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
pdc202xx.c:1453: warning: excess elements in scalar initializer
pdc202xx.c:1453: warning: (near initialization for `chipsets[3].init_dma')
make[3]: *** [pdc202xx.o] Error 1

-- 
Zlatko
