Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbRL0QkE>; Thu, 27 Dec 2001 11:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286345AbRL0Qjx>; Thu, 27 Dec 2001 11:39:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33810 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286343AbRL0Qjr>; Thu, 27 Dec 2001 11:39:47 -0500
Subject: Re: 2.2/2.4 Kernel oops/hang right after Calibrating delay loop...
To: dominik@aaf16.warszawa.sdi.tpnet.pl (Dominik Mierzejewski)
Date: Thu, 27 Dec 2001 16:45:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011227122505.GA5445@msp-150.man.olsztyn.pl> from "Dominik Mierzejewski" at Dec 27, 2001 01:25:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Jdef-00062O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, if anyone has _any_ idea where to look for the cause of this problem,
> we'd really appreciate it.
> Could this be a hardware problem?

Almost certainly. Check the heatsink/fan on the CPU, the voltages. Check the
RAM is seated ok and run memtest86 on it
