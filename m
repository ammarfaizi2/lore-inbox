Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290596AbSAYH46>; Fri, 25 Jan 2002 02:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290598AbSAYH4t>; Fri, 25 Jan 2002 02:56:49 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:38929 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S290596AbSAYH4k>; Fri, 25 Jan 2002 02:56:40 -0500
Subject: 2.5.3-pre5 -- Dependency not met linking vmlinux --
	drivers/char/pcmcia/pcmcia_char.o: No such file or directory
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 24 Jan 2002 23:55:28 -0800
Message-Id: <1011945328.2705.2.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ld: cannot open drivers/char/pcmcia/pcmcia_char.o: No such file or
directory
make: *** [vmlinux] Error 1

CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82092=y
CONFIG_I82365=y
CONFIG_TCIC=y

CONFIG_PCMCIA_SERIAL_CS=y
CONFIG_PCMCIA_CHRDEV=y


