Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSIJUcK>; Tue, 10 Sep 2002 16:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318113AbSIJUcK>; Tue, 10 Sep 2002 16:32:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4854 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318115AbSIJUcI>; Tue, 10 Sep 2002 16:32:08 -0400
Date: Tue, 10 Sep 2002 22:36:48 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Greg KH <greg@kroah.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [patch] add Configure.help entries for CONFIG_USB_SERIAL_KEYSPAN_USA19Q{W,I}
Message-ID: <Pine.NEB.4.44.0209102234040.18902-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the patch below adds Configure.help entries for
CONFIG_USB_SERIAL_KEYSPAN_USA19QW and CONFIG_USB_SERIAL_KEYSPAN_USA19QI
which were introduced in 2.4.20-pre.

cu
Adrian


--- Documentation/Configure.help.old	2002-09-10 22:27:30.000000000 +0200
+++ Documentation/Configure.help	2002-09-10 22:29:38.000000000 +0200
@@ -13773,6 +13773,14 @@
 CONFIG_USB_SERIAL_KEYSPAN_USA19W
   Say Y here to include firmware for the USA-19W converter.

+USB Keyspan USA-19QW Firmware
+CONFIG_USB_SERIAL_KEYSPAN_USA19QW
+  Say Y here to include firmware for the USA-19QW converter.
+
+USB Keyspan USA-19QI Firmware
+CONFIG_USB_SERIAL_KEYSPAN_USA19QI
+  Say Y here to include firmware for the USA-19QI converter.
+
 USB Keyspan USA-49W Firmware
 CONFIG_USB_SERIAL_KEYSPAN_USA49W
   Say Y here to include firmware for the USA-49W converter.

