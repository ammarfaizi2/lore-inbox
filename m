Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273624AbRIWVqs>; Sun, 23 Sep 2001 17:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273350AbRIWVqj>; Sun, 23 Sep 2001 17:46:39 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:60364 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S273326AbRIWVqZ>;
	Sun, 23 Sep 2001 17:46:25 -0400
Message-Id: <m15lH5A-000OVWC@amadeus.home.nl>
Date: Sun, 23 Sep 2001 22:46:36 +0100 (BST)
From: arjan@fenrus.demon.nl
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
In-Reply-To: <E15lH4e-0000VP-00@the-village.bc.nu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15lH4e-0000VP-00@the-village.bc.nu> you wrote:
>> If you took my patch for it, PLEASE don't send it for inclusion; it's an
>> evil hack and no longer needed when Intel fixes the bug in their 440GX bios.

> "when" is not a word I find useful about most bios bugs. Try "if" or
> "less likely that being hit on the head by an asteroid"

This case is different. Intel promised the update "soon". For them it's
simple, either they update or they can't say their 440GX boards are linux
compatible, because with the current bios they really aren't. 

They could also chose to open the "Intel Proprietary" information that is
needed to actually work with this board properly instead of via bios hacks,
but that's their choice...

Greetings,
   Arjan van de Ven
