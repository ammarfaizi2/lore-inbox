Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285556AbRLNWiK>; Fri, 14 Dec 2001 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285558AbRLNWiA>; Fri, 14 Dec 2001 17:38:00 -0500
Received: from AMontpellier-201-1-5-9.abo.wanadoo.fr ([193.251.15.9]:39177
	"EHLO awak") by vger.kernel.org with ESMTP id <S285556AbRLNWhq> convert rfc822-to-8bit;
	Fri, 14 Dec 2001 17:37:46 -0500
Subject: Re: freeze (2.4.17-pre/rc + Promise 20265)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Francois Romieu <romieu@cogenit.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011214231932.A2949@se1.cogenit.fr>
In-Reply-To: <20011214231932.A2949@se1.cogenit.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.14.09.00 (Preview Release)
Date: 14 Dec 2001 23:30:44 +0100
Message-Id: <1008369045.1793.46.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 14-12-2001 à 23:19, Francois Romieu a écrit :
> As soon as a disk is present in the first slot of the Promise adapter the 
> kernel locks during boot as shown below (no sysrq, no led, nothing)
> [...]
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
> PDC20265: IDE controller on PCI bus 00 dev 60
> PDC20265: chipset revision 2
> ide: Found promise 20265 in RAID mode.
> PDC20265: not 100% native mode: will probe irqs later
> PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
>     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio <- appears
> [insert guru meditation here]

Click left mouse button to restart and disable ACPI

	Xav

