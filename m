Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131918AbQKBO0J>; Thu, 2 Nov 2000 09:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131978AbQKBOZ7>; Thu, 2 Nov 2000 09:25:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16448 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131918AbQKBOZi>; Thu, 2 Nov 2000 09:25:38 -0500
Subject: Re: vesafb doesn't work in 240t10?
To: narancs1@externet.hu (Narancs 1)
Date: Thu, 2 Nov 2000 14:25:54 +0000 (GMT)
Cc: bpemberton@dingoblue.net.au (Brett),
        jgarzik@mandrakesoft.com (Jeff Garzik), kraxel@goldbach.in-berlin.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.02.10011021512560.5828-100000@prins.externet.hu> from "Narancs 1" at Nov 02, 2000 03:15:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rLJT-0001b2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems that the i815 is not vesa compliant?
> Cheap!

The i810 hardware only has limited support for old style linear video modes
so that is quite possible.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
