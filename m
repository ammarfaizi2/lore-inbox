Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283291AbRK2QNa>; Thu, 29 Nov 2001 11:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283306AbRK2QNU>; Thu, 29 Nov 2001 11:13:20 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.254.5]:33492 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S283303AbRK2QNF>; Thu, 29 Nov 2001 11:13:05 -0500
Subject: where the hell is pci_read_config_xyz defined
From: Daniel Stodden <stodden@in.tum.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 17:12:57 +0100
Message-Id: <1007050377.32308.0.camel@atbode65>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all.

i hope this question is not too stupid,
but i think i've grepped all through it now.

i see the prototype in linux/pci.h
i looked at i386/kernel/pci-pc.c.
i see the bios/direct access diversion. i don't see (*pci_config_read)()
referenced elsewhere except within the acpi stuff.
i looked at drivers/pci/*
i even consulted lxr. nyet. nada.

giving up now. any hint would be greatly appreciated. am i blind?

thanx,
dns


-- 
__________________________________________________________________
mailto: stodden@in.tum.de

