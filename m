Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269134AbRHLMCo>; Sun, 12 Aug 2001 08:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbRHLMCZ>; Sun, 12 Aug 2001 08:02:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9741 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269134AbRHLMCY>; Sun, 12 Aug 2001 08:02:24 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: jhingber@ix.netcom.com (Jeffrey Ingber)
Date: Sun, 12 Aug 2001 13:04:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <997611819.29909.25.camel@DESK-2> from "Jeffrey Ingber" at Aug 12, 2001 06:23:33 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VtzC-0005e6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've used ALSA for quite awhile for EMU10k1 (E-MU APS, not SBLive) and
> have had no problems.  I noticed that the EMU10K1 driver was updated in
> 2.4.8 so I tried it.  I had a lockup four times during audio playback,
> so I switched back to ALSA and now everything is stable once again.

The in kernel one seemed fine. The 2.4.8 update one is definitely broken on
SMP boxes
