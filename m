Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTIOMef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbTIOMef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:34:35 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:63628 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S261309AbTIOMed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:34:33 -0400
Date: Mon, 15 Sep 2003 14:18:08 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre4-pac1
Message-ID: <Pine.LNX.4.56.0309151411010.14486@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$SUBJECT is ready and can be downloaded at

http://www.arklinux.org/~bero/kernel/patch-2.4.23-pre4-pac1.bz2
GPG sig: http://www.arklinux.org/~bero/kernel/patch-2.4.23-pre4-pac1.bz2.asc

Changes:
- Port to 2.4.23-pre4
- Fix build of SATA drivers
- Fix Config.in bug that prevented SATA drivers from being compiled with
  modular SCSI
- Sync DRI with xf86 tree, add ATI IGP support
- Fix taking down network devices (Patch from Jeff Garzik on LKML)
- Fix compilation of atyfb with GENERIC_LCD enabled
  ["It compiles, therefore it works(tm)" due to lack of hardware for 
  testing]


-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
