Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268015AbRHBA3G>; Wed, 1 Aug 2001 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268021AbRHBA24>; Wed, 1 Aug 2001 20:28:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57356 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268015AbRHBA2v>; Wed, 1 Aug 2001 20:28:51 -0400
Subject: Re: SMP possible with AMD CPUs?
To: joelja@darkwing.uoregon.edu (Joel Jaeggli)
Date: Thu, 2 Aug 2001 01:30:19 +0100 (BST)
Cc: nyh@math.technion.ac.il (Nadav Har'El), linux-kernel@vger.kernel.org,
        agmon@techunix.technion.ac.il
In-Reply-To: <Pine.LNX.4.33.0108011318120.19875-100000@twin.uoregon.edu> from "Joel Jaeggli" at Aug 01, 2001 01:22:00 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S6NY-00086O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the combination of the athlon mp and the amd 761 chipset will do
> multiprocessor support without trouble... you will want to use 2.4 becuase
> lots of devices on the boards  aren't supported by 2.2...

Athlon SMP will actually not always work with 2.2. Quite a few folks
reported problems and patches for 2.2.20pre fixes that and broke other
stuff so got reverted.

2.4 seems to do the job nicely

