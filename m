Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSAFWVa>; Sun, 6 Jan 2002 17:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSAFWUW>; Sun, 6 Jan 2002 17:20:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282967AbSAFWUH>; Sun, 6 Jan 2002 17:20:07 -0500
Subject: Re: ISA slot detection on PCI systems?
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sun, 6 Jan 2002 22:16:53 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20020106220336.A30738@suse.cz> from "Vojtech Pavlik" at Jan 06, 2002 10:03:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NLb4-0006n5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't propose having human-readable output of DMI data in /proc, just
> the binary data much like /proc/bus/pci has. That isn't much bloat in
> kernel, and is a clearly defined interface, unlike reading /dev/kmem.

kmem is a cleanly defined interface
