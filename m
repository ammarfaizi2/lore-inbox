Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSFDAEf>; Mon, 3 Jun 2002 20:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSFDAEe>; Mon, 3 Jun 2002 20:04:34 -0400
Received: from [129.46.51.59] ([129.46.51.59]:64243 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S315929AbSFDAEc>; Mon, 3 Jun 2002 20:04:32 -0400
Message-Id: <5.1.0.14.2.20020603164649.07e75f80@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Jun 2002 17:04:08 -0700
To: torvalds@transmeta.com
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [PATCH] 2.5.20 Bluetooth PCMCIA drivers update
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch cleans up code formatting of the Bluetooth PCMCIA drivers
and fixes duplicate definitions of the non static variables.

drivers/bluetooth/bluecard_cs.c |   75 +-
drivers/bluetooth/dtl1_cs.c     | 1338 ++++++++++++++++++----------------------
2 files changed, 663 insertions(+), 750 deletions(-)

http://bluez.sourceforge.net/patches/bluez-2.5.20-pcmcia-drv.gz

Please apply
Max

