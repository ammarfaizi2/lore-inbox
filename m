Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVKBUSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVKBUSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVKBUSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:18:12 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:25293
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965218AbVKBUSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:18:12 -0500
Subject: [PATCH] new driver synclink_gt
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1130962689.5289.8.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 02 Nov 2005 14:18:09 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches for a new character device driver for
the SyncLink GT and SyncLink AC families of
synchronous and asynchronous serial adapters
are located at (patches too large for mailing list):

http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-Kconfig
http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-Makefile
http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-synclink.h
http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/patch-2.6.14-synclink_gt.c

The complete driver in non patch form is at
http://www.microgate.com/ftp/linux/synclink_gt-2.6.14/synclink_gt.c

This driver had been tested for a few months and these
particular patches have been tested against 2.6.14

-- 
Paul Fulghum
paulkf@microgate.com

