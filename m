Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSABQBM>; Wed, 2 Jan 2002 11:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287861AbSABQBC>; Wed, 2 Jan 2002 11:01:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5643 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287859AbSABQAr>; Wed, 2 Jan 2002 11:00:47 -0500
Subject: Re: [PATCH][RFC] AMD Elan patch
To: davej@suse.de (Dave Jones)
Date: Wed, 2 Jan 2002 16:10:35 +0000 (GMT)
Cc: robert@schwebel.de (Robert Schwebel), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        wingel@hog.ctrl-c.liu.se (Christer Weinigel),
        jason@mugwump.taiga.com (Jason Sodergren),
        anders@alarsen.net (Anders Larsen), rkaiser@sysgo.de
In-Reply-To: <Pine.LNX.4.33.0201021502160.427-100000@Appserv.suse.de> from "Dave Jones" at Jan 02, 2002 03:03:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LnyN-0004aG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> x86info is the closest thing to a complete list, but as hpa pointed out,
> the problem identifying the cpu is easy, identifying the chipset is the
> hard part.

I can guarantee 100% correct chipset identification. If you meet an ELAN410
it is the chipset too. The ISA and VLB come directly off the CPU
