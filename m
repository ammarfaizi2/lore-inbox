Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280931AbRKDRX2>; Sun, 4 Nov 2001 12:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKDRXI>; Sun, 4 Nov 2001 12:23:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16647 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280043AbRKDRXF>; Sun, 4 Nov 2001 12:23:05 -0500
Subject: Re: emu10k emits buzzing and crackling
To: rui.p.m.sousa@clix.pt (Rui Sousa)
Date: Sun, 4 Nov 2001 17:29:47 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), rui.p.m.sousa@clix.pt (Rui Sousa),
        sirmorcant@morcant.org (Morgan Collins [Ax0n]), kwijibo@zianet.com,
        bcrl@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111041813310.3150-100000@sophia-sousar2.nice.mindspeed.com> from "Rui Sousa" at Nov 04, 2001 06:18:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160R5f-0002Sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > GNOME pretty much requires esd, like KDE requires arts.
> 
> For most common sound cards. Not when you can have 32 independent stereo 
> sound streams.

You still need esd/arts. You can't play remote audio otherwise.
