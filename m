Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbUA1Qa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 11:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUA1Qa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 11:30:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:39326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265980AbUA1QaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 11:30:20 -0500
From: john cherry <cherry@osdl.org>
Date: Wed, 28 Jan 2004 08:30:19 -0800
Message-Id: <200401281630.i0SGUJd06189@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2-rc2 - 2004-01-27.17.30) - 40 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/i2c/busses/i2c-elv.c:104: warning: cast to pointer from integer of different size
drivers/i2c/busses/i2c-elv.c:105: warning: cast to pointer from integer of different size
drivers/i2c/busses/i2c-elv.c:147: warning: cast to pointer from integer of different size
drivers/i2c/busses/i2c-elv.c:61: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-elv.c:71: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-elv.c:76: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-elv.c:81: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:133: warning: cast to pointer from integer of different size
drivers/i2c/busses/i2c-velleman.c:60: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:62: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:70: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:72: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:79: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:84: warning: cast from pointer to integer of different size
drivers/i2c/busses/i2c-velleman.c:93: warning: cast to pointer from integer of different size
drivers/i2c/busses/i2c-velleman.c:94: warning: cast to pointer from integer of different size
drivers/i2c/chips/lm85.c:1114: warning: comparison is always true due to limited range of data type
drivers/i2c/i2c-dev.c:143: warning: int format, different type arg (arg 3)
drivers/i2c/i2c-dev.c:171: warning: int format, different type arg (arg 3)
drivers/media/dvb/bt8xx/bt878.c:520: warning: large integer implicitly truncated to unsigned type
drivers/media/video/zoran_card.c:149: warning: `zr36067_pci_tbl' defined but not used
drivers/media/video/zoran_device.c:535: warning: cast from pointer to integer of different size
drivers/media/video/zoran_driver.c:2272: warning: cast from pointer to integer of different size
drivers/media/video/zoran_driver.c:3760: warning: long long unsigned int format, long unsigned int arg (arg 3)
drivers/media/video/zoran_driver.c:3774: warning: long long unsigned int format, long unsigned int arg (arg 3)
drivers/media/video/zoran_driver.c:4105: warning: long long unsigned int format, long unsigned int arg (arg 3)
drivers/media/video/zoran_procfs.c:189: warning: cast to pointer from integer of different size
drivers/media/video/zoran_procfs.c:223: warning: cast from pointer to integer of different size
drivers/usb/media/w9968cf.c:2078: warning: int format, different type arg (arg 3)
drivers/usb/media/w9968cf.c:2078: warning: int format, different type arg (arg 5)
drivers/usb/media/w9968cf.c:2833: warning: int format, different type arg (arg 3)
drivers/usb/media/w9968cf.c:2833: warning: int format, different type arg (arg 5)
drivers/usb/media/w9968cf.c:3510: warning: int format, different type arg (arg 3)
drivers/usb/media/w9968cf.c:3510: warning: int format, different type arg (arg 5)
drivers/usb/media/w9968cf.c:824: warning: int format, different type arg (arg 3)
drivers/usb/media/w9968cf.c:824: warning: int format, different type arg (arg 5)
drivers/usb/media/w9968cf.c:862: warning: int format, different type arg (arg 3)
drivers/usb/media/w9968cf.c:862: warning: int format, different type arg (arg 5)
drivers/video/matrox/matroxfb_maven.c:347: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:348: warning: duplicate `const'
