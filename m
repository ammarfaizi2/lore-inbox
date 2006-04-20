Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWDTVyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWDTVyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWDTVyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:54:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25757 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751348AbWDTVyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:54:54 -0400
Date: Thu, 20 Apr 2006 23:54:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Small make output indent glitch
Message-ID: <Pine.LNX.4.61.0604202353130.28841@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


while compiling 2.6.17-rc2 with allyesconfig, this showed up

...
  LOGO  drivers/video/logo/logo_superh_clut224.c
  CC      drivers/video/logo/logo_linux_mono.o
...



Jan Engelhardt
-- 
