Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318750AbSIFPgt>; Fri, 6 Sep 2002 11:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSIFPgs>; Fri, 6 Sep 2002 11:36:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46792 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318750AbSIFPfq>; Fri, 6 Sep 2002 11:35:46 -0400
Date: Fri, 6 Sep 2002 17:40:19 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
In-Reply-To: <200209061500.g86F08m12929@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0209061735390.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

while doing a "make oldconfig" I noticed that there are some new options
without a Configure.help entry:

CONFIG_X86_LONGHAUL_SCALE_VOLTAGE
CONFIG_SUMMIT
CONFIG_HOTPLUG_PCI_H2999
CONFIG_BLK_DEV_IDECD_BAILOUT
CONFIG_BLK_DEV_GENERIC
CONFIG_BLK_DEV_NFORCE
CONFIG_BLK_DEV_PDC202XX_OLD
CONFIG_BLK_DEV_PDC202XX_NEW
CONFIG_BLK_DEV_SIIMAGE
CONFIG_ALIM1535_WDT
CONFIG_AMD7XX_TCO
CONFIG_AMD_PM768
CONFIG_VIDEO_LS220
CONFIG_VIDEO_MARGI
CONFIG_FB_RADEON_VAIO_LCD
CONFIG_USB_SERIAL_KEYSPAN_USA19QW
CONFIG_USB_SERIAL_KEYSPAN_USA19QI
CONFIG_USB_LCD


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

