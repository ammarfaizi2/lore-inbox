Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUDPMmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUDPMmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:42:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:23525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263154AbUDPMmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:42:05 -0400
Date: Fri, 16 Apr 2004 05:42:02 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200404161242.i3GCg2YE021447@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6-rc1 - 2004-04-15.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/r8169.c:50:1: warning: "DMA_32BIT_MASK" redefined
include/linux/dma-mapping.h:14:1: warning: this is the location of the previous definition
