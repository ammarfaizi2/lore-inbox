Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbSJPJPR>; Wed, 16 Oct 2002 05:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264985AbSJPJPR>; Wed, 16 Oct 2002 05:15:17 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:20214 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S264984AbSJPJPP>; Wed, 16 Oct 2002 05:15:15 -0400
Subject: 2.5.43 - media/video/zr36120.h:29:27: linux/i2c-old.h: No such
	file or directory
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1034759764.3983.11.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 02:16:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,drivers/media/video/.zr36120.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE   -DKBUILD_BASENAME=zr36120   -c -o
drivers/media/video/zr36120.o drivers/media/video/zr36120.c
In file included from drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or
directory

CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_W9966=m
CONFIG_VIDEO_CPIA=m
# CONFIG_VIDEO_CPIA_PP is not set
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZR36120=m




