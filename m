Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSHQU0r>; Sat, 17 Aug 2002 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318732AbSHQU0r>; Sat, 17 Aug 2002 16:26:47 -0400
Received: from iris.duna.pl ([217.98.70.4]:8064 "EHLO aurora.pnt")
	by vger.kernel.org with ESMTP id <S318731AbSHQU0q>;
	Sat, 17 Aug 2002 16:26:46 -0400
Date: Sat, 17 Aug 2002 22:30:10 +0200
From: Justyna =?iso-8859-2?Q?Bia=B3a?= <nell@poczta.gazeta.pl>
To: linux-kernel@vger.kernel.org
Subject: kernel panic while cd writing
Message-ID: <20020817203010.GA251@poczta.gazeta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have LiteOn 40x12x48x cd-writer, linux 2.4.19, cdrecord 1.11a24,
Duron 1000 MHz, ECS K7S5A with SIS735 chipset. My cd-writer works fine only 
in two cases:
1. when the speed is not higher than 12x (no matter if the dma is on)
2. with speed = 32x but only when I turn the dma off with hdparm

In other cases after a few whiles from the begining of burning process
the whole system crashes whith such messages:

"unable to handle paging request at virtual address 199EC3F7"
"oops: 0002"
"kernel panic: aiee, killing interrupt handler!"

Can you give me any advices what should I do with that?

nell
-- 
Escape of the Unicorn
[free, 2D, flying shooter game]
http://eounicorn.sourceforge.net
