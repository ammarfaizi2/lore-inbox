Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287160AbSABXC0>; Wed, 2 Jan 2002 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287163AbSABXCG>; Wed, 2 Jan 2002 18:02:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287155AbSABXB5>; Wed, 2 Jan 2002 18:01:57 -0500
Subject: Re: [PATCH][RFC] AMD Elan patch
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 2 Jan 2002 23:10:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        robert@schwebel.de (Robert Schwebel),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        wingel@hog.ctrl-c.liu.se (Christer Weinigel),
        jason@mugwump.taiga.com (Jason Sodergren),
        anders@alarsen.net (Anders Larsen), rkaiser@sysgo.de
In-Reply-To: <3C338C57.2080902@zytor.com> from "H. Peter Anvin" at Jan 02, 2002 02:40:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LuX4-0005wH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not the problem, really... the problems is that CPUID identifies 
> the CPU core, and embedded CPU cores tend to be used and reused many 
> times -- in fact, AMD are quite good at that.

The 400/410 this isnt a problem for. Its discontinued and the 5x0 detect
differently (and actually have working serial ports I believe). So its
an end of life core
