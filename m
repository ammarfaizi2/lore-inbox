Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293081AbSCABCD>; Thu, 28 Feb 2002 20:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293629AbSCAA55>; Thu, 28 Feb 2002 19:57:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46864 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310200AbSCAAyU>; Thu, 28 Feb 2002 19:54:20 -0500
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
To: texas@ludd.luth.se (texas)
Date: Fri, 1 Mar 2002 01:09:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSU.4.33.0202281949410.27596-100000@father.ludd.luth.se> from "texas" at Feb 28, 2002 07:53:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbXt-0001s7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tried 2.2 again thinking it might work now with the fixed BIOS settings
> but no, still getting the "Keyboard: Timeout - AT keyboard not present?"
> and "hda: lost interrupt" messages. So I can't even boot 2.2 and I have no

I guess that box is always assuming PnP or ACPI setup in which case 2.2
will never work on it.

Cold boot in the sense that reset buttons don't work or cold in the sense
ctrl-alt-del doesn't work. If the reset button isn't working thats a real
"hardware died" alarm bell
