Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSBZWza>; Tue, 26 Feb 2002 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBZWzK>; Tue, 26 Feb 2002 17:55:10 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:8715 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S285720AbSBZWzD>;
	Tue, 26 Feb 2002 17:55:03 -0500
Date: Tue, 26 Feb 2002 23:54:55 +0100 (CET)
From: Pau <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: how to migrate these drivers?
Message-ID: <Pine.LNX.4.44.0202262352290.17648-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to fix these drivers so that they compile in 2.5. Is anybody 
working on it? Any rule of the thumb to do it?

Thanks

depmod: *** Unresolved symbols in 
/var/tmp/kernel-2.5.6pre1-root/lib/modules/2.5.6-pre1/kernel/drivers/media/video/bttv.o
depmod: 	virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in 
/var/tmp/kernel-2.5.6pre1-root/lib/modules/2.5.6-pre1/kernel/drivers/net/pcmcia/xircom_tulip_cb.o
depmod: 	bus_to_virt_not_defined_use_pci_map
depmod: 	virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in 
/var/tmp/kernel-2.5.6pre1-root/lib/modules/2.5.6-pre1/kernel/net/irda/irda.o
depmod: 	virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in 
/var/tmp/kernel-2.5.6pre1-root/lib/modules/2.5.6-pre1/kernel/sound/oss/maestro.o
depmod: 	virt_to_bus_not_defined_use_pci_map
depmod: *** Unresolved symbols in 
/var/tmp/kernel-2.5.6pre1-root/lib/modules/2.5.6-pre1/kernel/sound/oss/sound.o
depmod: 	virt_to_bus_not_defined_use_pci_map
make[1]: *** [_modinst_post] Error 1


Pau

