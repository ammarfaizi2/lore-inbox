Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSCLOG4>; Tue, 12 Mar 2002 09:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311207AbSCLOGr>; Tue, 12 Mar 2002 09:06:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15366 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311206AbSCLOGj>; Tue, 12 Mar 2002 09:06:39 -0500
Subject: Re: strange dmesg output on athlon notebook
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 12 Mar 2002 14:22:14 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020310220056.GA189@elf.ucw.cz> from "Pavel Machek" at Mar 10, 2002 11:00:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16knAM-0003pe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPU: After vendor init, caps: 0383fbff c1c7fbff 00000000 00000000
> Intel machine check reporting enabled on CPU#0.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Why _Intel_ machine check? And why it says  CPU: After vendor init
> twice? [This is 2.5.6-acpi...]

AMD supports the intel machine check on Athlon

