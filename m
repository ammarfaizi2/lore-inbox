Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRKDRAG>; Sun, 4 Nov 2001 12:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKDQ77>; Sun, 4 Nov 2001 11:59:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6663 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280026AbRKDQ7t>; Sun, 4 Nov 2001 11:59:49 -0500
Subject: Re: emu10k emits buzzing and crackling
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 4 Nov 2001 17:06:20 +0000 (GMT)
Cc: rui.p.m.sousa@clix.pt (Rui Sousa),
        sirmorcant@morcant.org (Morgan Collins [Ax0n]), kwijibo@zianet.com,
        bcrl@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BE572DC.4BD4958E@mandrakesoft.com> from "Jeff Garzik" at Nov 04, 2001 11:54:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160Qiy-0002Np-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> emu10k1 provides in-kernel support for multiple userspace apps sharing a
> single /dev/dsp0 connection?  :)

The hardware has something like 512 channels. esd sadly wont make sensible
use of this. I'm not sure if Arts will

> GNOME pretty much requires esd, like KDE requires arts.

Expect gnome to be using arts soon
