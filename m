Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287212AbSBKFtK>; Mon, 11 Feb 2002 00:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287254AbSBKFtA>; Mon, 11 Feb 2002 00:49:00 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:12305 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287212AbSBKFs4>; Mon, 11 Feb 2002 00:48:56 -0500
Subject: 2.5.4 -- Unresolved virt_to_bus_not_defined_use_pci_map in
	xircom_tulip_cb.o and sound.o
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 21:45:42 -0800
Message-Id: <1013406343.30864.48.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



depmod: *** Unresolved symbols in
/lib/modules/2.5.4-pre6/kernel/drivers/net/pcmcia/xircom_tulip_cb.o
depmod: 	bus_to_virt_not_defined_use_pci_map
depmod: 	virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in
/lib/modules/2.5.4-pre6/kernel/drivers/sound/sound.o
depmod: 	virt_to_bus_not_defined_use_pci_map

