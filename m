Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUEVBcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUEVBcr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUEUXqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:46:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47802 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264601AbUEUX16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:27:58 -0400
Date: Thu, 20 May 2004 05:43:54 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405201243.i4KChs8B017018@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6 - 2004-05-19.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/vga16fb.c:1350: warning: assignment makes pointer from integer without a cast
