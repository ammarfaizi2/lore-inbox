Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283685AbRK3PuP>; Fri, 30 Nov 2001 10:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283687AbRK3PuH>; Fri, 30 Nov 2001 10:50:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283685AbRK3Ptb>; Fri, 30 Nov 2001 10:49:31 -0500
Subject: Re: Deadlock on kernels > 2.4.13-pre6
To: emmanuele.bassi@iol.it (Emmanuele Bassi)
Date: Fri, 30 Nov 2001 15:54:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011130164031.A8741@wolverine.lohacker.net> from "Emmanuele Bassi" at Nov 30, 2001 04:40:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169pzm-0003sq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So far, I've excluded everything but a bug in the OSS sound drivers,
> but, according to the ChangeLogs, they did not change from 2.4.13-pre6
> (the last working kernel) to 2.4.13.

The OSS core and SB AWE driver have to all intents not changed since before
2.4 was released.

You might want to check when the  various VIA chipset fixes went in if you
are using a VIA chipset
