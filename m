Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281405AbRKEWe2>; Mon, 5 Nov 2001 17:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281406AbRKEWeS>; Mon, 5 Nov 2001 17:34:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17413 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281405AbRKEWeH>; Mon, 5 Nov 2001 17:34:07 -0500
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
To: groudier@free.fr (=?ISO-8859-1?Q?G=E9rard_Roudier?=)
Date: Mon, 5 Nov 2001 22:40:39 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul),
        jgarzik@mandrakesoft.com (Jeff Garzik), john@fremlin.de (John Fremlin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011105175245.X1658-100000@gerard> from "=?ISO-8859-1?Q?G=E9rard_Roudier?=" at Nov 05, 2001 06:04:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160sQ3-0006tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you would have preferred, for example, to have dozens of different
> drivers for SYM53C8XX chips and probably as many for Adaptec aic7xxx on=
> es.

The problem with tulip clones is a bit different. Imagine if each SYS53C8XX
chip had ten clone versions that each understood 90% of the official
instruction set and had different magically unique bugs some of which were
not documented.

Dealing with things like GPIO variants, LED wiring, custom NVRAM is a bit
cleaner. The very core of the tulip clones is variable

Alan
