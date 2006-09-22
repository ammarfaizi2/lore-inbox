Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWIVWXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWIVWXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbWIVWXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:23:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10758 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965229AbWIVWXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:23:02 -0400
Date: Sat, 23 Sep 2006 00:23:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.30-pre1
Message-ID: <20060922222300.GA5566@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.29:

Adrian Bunk:
      V4L/DVB: Saa7134: document that there's also a 220RF from KWorld
      add drivers/media/video/saa7134/saa7134-input.c:flydvb_codes
      Linux 2.6.16.30-pre1

Andrew Burri:
      V4L/DVB: Add support for Kworld ATSC110

Curt Meyers:
      V4L/DVB: KWorld ATSC110: implement set_pll_input
      V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
      V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load

Giampiero Giancipoli:
      V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card

Hartmut Hackmann:
      V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
      V4L/DVB: Added PCI IDs of 2 LifeView Cards
      V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
      V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
      V4L/DVB: TDA10046 Driver update
      V4L/DVB: TDA8290 update

Peter Hartshorn:
      V4L/DVB: Added support for the Tevion DVB-T 220RF card

Henk Vergonet:
      USB: Fix unload oops and memory leak in yealink driver
      USB: add YEALINK phones to the HID_QUIRK_IGNORE blacklist

Jay Cliburn:
      via-velocity: fix speed and link status reported by ethtool

Jose Alberto Reguero:
      V4L/DVB: Add support for the Avermedia 777 DVB-T card

Julien Tous:
      [AGPGART] ATI RS350 support.

Magnus Kessler:
      [AGPGART] VIA PT880 Ultra support.

Mark M. Hoffman:
      I2C: fix 'ignore' module parameter handling

Martin Schwidefsky:
      kernel/kmod.c: fix a race condition in usermodehelper.

maximilian attems:
      V4L/DVB: Saa7134: select FW_LOADER

Michael Krufky:
      V4L/DVB: Kworld ATSC110: cleanups
      V4L/DVB: Saa7134: make unsupported secondary decoder message generic
      V4L/DVB: Medion 7134: Autodetect second bridge chip

Michael Rash:
      [TEXTSEARCH]: Fix Boyer Moore initialization bug

Rickard Osser:
      V4L/DVB: Saa7134: add support for AVerMedia A169 Dual Analog tuner card

Roland Dreier:
      Convert idr's internal locking to _irqsave variant

Roy Marples:
      via-velocity: the link is not correctly detected when the device starts

Tamuki Shoichi:
      V4L/DVB: Add saa713x card: ELSA EX-VISION 700TV (saa7130)
      V4L/DVB: ELSA EX-VISION 700TV: fix incorrect PCI subsystem ID

Tushar Gohad:
      PFKEYV2: Fix inconsistent typing in struct sadb_x_kmprivate.


