Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbRF1MVV>; Thu, 28 Jun 2001 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbRF1MVL>; Thu, 28 Jun 2001 08:21:11 -0400
Received: from mail.mesatop.com ([208.164.122.9]:41222 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S265646AbRF1MVC>;
	Thu, 28 Jun 2001 08:21:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Fourteen new undocumented symbols in 2.4.6-pre6
Date: Thu, 28 Jun 2001 06:14:11 -0600
X-Mailer: KMail [version 1.2]
Cc: esr@thyrsus.com
MIME-Version: 1.0
Message-Id: <01062806141101.01146@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

2.4.6-pre6 introduces 14 new undocumented symbols.
Would the owners please provide help texts for the following:

CONFIG_CPU_SUBTYPE_SH7751
CONFIG_CPU_SUBTYPE_ST40STB1
CONFIG_HD64465_IOBASE
CONFIG_MAPLE_KEYBOARD
CONFIG_MAPLE_MOUSE
CONFIG_SH_7751_SOLUTION_ENGINE
CONFIG_SH_BIGSUR
CONFIG_SH_CAT68701
CONFIG_SH_SH2000
CONFIG_SH_STB1_HARP
CONFIG_SH_STB1_OVERDRIVE
CONFIG_ST40_LMI_MEMORY
CONFIG_TULIP_MMIO
CONFIG_TULIP_MWI

The SuperH ones are just items in a choice menu, so they can be one-liners.

Thanks in advance,
Steven
