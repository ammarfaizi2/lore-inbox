Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288384AbSA0TZC>; Sun, 27 Jan 2002 14:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288402AbSA0TYw>; Sun, 27 Jan 2002 14:24:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22025 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288384AbSA0TYh>; Sun, 27 Jan 2002 14:24:37 -0500
Subject: Re: ISA PNP sound card not detected
To: partenie_a@k.ro (Adrian Partenie)
Date: Sun, 27 Jan 2002 19:37:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201260216.g0Q2G2D05333@www.k.ro> from "Adrian Partenie" at Jan 26, 2002 04:16:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Uv76-0002FV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux I used it with Red Hat 6.0 and 7.0 (kernels 2.2.5-15 and 2.2.16)
> which worked almost fine (except the well known fact that SoundBlaster
> under Linux is supported only on 8bits, Mad16 module didn't worked and was

SB is supported 8 and 16bit

> silent until booted with loadlin). I used the pnpdump and isapnp to
> configure it and the sb.o module (with module dependencies sound,

pnpdump and isapnp tools are not really compatible with 2.4

