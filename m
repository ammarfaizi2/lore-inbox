Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRKGKlX>; Wed, 7 Nov 2001 05:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRKGKlN>; Wed, 7 Nov 2001 05:41:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280474AbRKGKlF>; Wed, 7 Nov 2001 05:41:05 -0500
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
To: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 7 Nov 2001 10:47:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux@hazard.jcu.cz (Jan Marek),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <14838.1005128999@redhat.com> from "David Woodhouse" at Nov 07, 2001 10:29:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161QEm-0003jO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We know enough about that hardware to turn the IRQ off from Linux, don't we?
> If it's a common problem, we could make a PCI quirk for it.

Maybe. Wonder what happens if you stick it into D3 power off 

