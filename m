Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272241AbRIKBKg>; Mon, 10 Sep 2001 21:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272242AbRIKBKR>; Mon, 10 Sep 2001 21:10:17 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:21261 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S272241AbRIKBKJ>;
	Mon, 10 Sep 2001 21:10:09 -0400
Date: Mon, 10 Sep 2001 22:11:07 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: linux-kernel@vger.kernel.org
Subject: Duron kernel crash (i686 works)
Message-ID: <Pine.GSO.4.21.0109102207010.24461-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo KT133A
chipset). The kernel I had (2.4.9) started crashing on boot with an
invalid page fault, usually right after starting init. I tryed a i686
kernel and noticed it works OK, so I recompiled my crashy kernel only
switching the processor type and it also worked. changed it back to
Athlon/K7/Duron and it starts crashing.

Anyone else experiencing this?

TIA,

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

