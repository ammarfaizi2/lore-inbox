Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279543AbRJ2Vfg>; Mon, 29 Oct 2001 16:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279559AbRJ2Vf0>; Mon, 29 Oct 2001 16:35:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8459 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279543AbRJ2VfS>; Mon, 29 Oct 2001 16:35:18 -0500
Subject: Re: opl3sa2 sound driver and mixers
To: dpalffy@kkt.bme.hu (PALFFY Daniel)
Date: Mon, 29 Oct 2001 21:40:46 +0000 (GMT)
Cc: agd5f@yahoo.com (Alex Deucher), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110292228040.24547-100000@iris.kkt.bme.hu> from "PALFFY Daniel" at Oct 29, 2001 10:32:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yK9H-00048j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please read Documentation/sound/OPL3-SA2 (the two mixers are intentional,
> some channels are available only on the MSS mixer, others only on the
> OPL3-SA2), and don't break the driver! Since the latest DMA fix finally
> everything works fine on my Portege 3010 (which is exactly the same as the
> 3020 except for a slower CPU and smaller disk).

Thanks for warning me and saving me the effort of decoding it all



