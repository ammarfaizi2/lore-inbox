Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273179AbRIWVgR>; Sun, 23 Sep 2001 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273186AbRIWVgG>; Sun, 23 Sep 2001 17:36:06 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:52684 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S273179AbRIWVfu>;
	Sun, 23 Sep 2001 17:35:50 -0400
Message-Id: <m15lGv2-000OVWC@amadeus.home.nl>
Date: Sun, 23 Sep 2001 22:36:08 +0100 (BST)
From: arjan@fenrus.demon.nl
To: andrea@suse.de (Andrea Arcangeli)
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010923232511.B1466@athlon.random>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010923232511.B1466@athlon.random> you wrote:

> Only in 2.4.10aa1: 00_enable-apic-1

>        Enable UP ioapic on demand via boot param.

If you took my patch for it, PLEASE don't send it for inclusion; it's an
evil hack and no longer needed when Intel fixes the bug in their 440GX bios.

Greetings,
   Arjan van de Ven
