Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbREHVQB>; Tue, 8 May 2001 17:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREHVPv>; Tue, 8 May 2001 17:15:51 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:9920 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S135491AbREHVPj>;
	Tue, 8 May 2001 17:15:39 -0400
Message-Id: <m14xEp5-000OWpC@amadeus.home.nl>
Date: Tue, 8 May 2001 22:15:11 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <3AF2FF93.44A2C49@colorfullife.com> <E14vnMM-00084d-00@the-village.bc.nu>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14vnMM-00084d-00@the-village.bc.nu> you wrote:
> Arjan - care to unroll the tail 320 bytes of copying from the main loop ?

I'll see what I can do to make us not loose too much speed.
