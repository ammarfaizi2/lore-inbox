Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUIMOUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUIMOUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIMOUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:20:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:54957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266898AbUIMOTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:19:23 -0400
Date: Mon, 13 Sep 2004 07:19:21 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409131419.i8DEJLl2030793@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc1 - 2004-09-12.21.30) - 12 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/mtd/maps/dilnetpc.c:406: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/dilnetpc.c:416: warning: long unsigned int format, pointer arg (arg 2)
drivers/mtd/maps/l440gx.c:76: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/netsc520.c:98: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/nettel.c:277: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/nettel.c:362: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/nettel.c:396: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/physmap.c:54: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/pnc2000.c:34: warning: initialization makes pointer from integer without a cast
drivers/mtd/maps/sc520cdp.c:244: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/scb2_flash.c:166: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/scx200_docflash.c:183: warning: assignment makes pointer from integer without a cast
