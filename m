Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274904AbRIXT0R>; Mon, 24 Sep 2001 15:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274905AbRIXT0F>; Mon, 24 Sep 2001 15:26:05 -0400
Received: from smtp3.libero.it ([193.70.192.53]:18169 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S274904AbRIXTZv> convert rfc822-to-8bit;
	Mon, 24 Sep 2001 15:25:51 -0400
Subject: Tritech ???
From: "[A]ndy80" <andy80@ptlug.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14.99+cvs.2001.09.22.08.08 (Preview Release)
Date: 24 Sep 2001 21:34:12 +0200
Message-Id: <1001360061.1047.11.camel@piccoli>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is my kernel configuration about SOUND:


#
Sound                                                                         #                                                                               CONFIG_SOUND=y                                                                  
# CONFIG_SOUND_BT878 is not
set                                                       

CONFIG_SOUND_EMU10K1=y             

I ONLY enable EMU10K1 but, during boot I see:


Creative EMU10K1 PCI Audio Driver, version 0.15, 20:31:39 Sep 24 2001
PCI: Found IRQ 10 for device 00:11.0
emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xe000-0xe01f, IRQ 10
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)

why does kernel load that module?




-- 
   ~            Piccoli Software
  ° °	http://www.piccolisoftware.cjb.net
  /V\      piccolisoftware@pegacity.it
 // \\
/(   )\  [A]ndy80 on #bluvertigo e #pistoia
 ^`~'^  andy80@ptlug.org - http://www.ptlug.org

GPG Key: http://www.ptlug.org/andy80_key.asc

