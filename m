Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTIZFsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 01:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTIZFsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 01:48:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:38298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261938AbTIZFsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 01:48:36 -0400
Date: Thu, 25 Sep 2003 22:48:35 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309260548.h8Q5mZt3015714@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 6 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/drm/sis_mm.c:105: warning: implicit declaration of function `sis_free'
drivers/char/drm/sis_mm.c:135: warning: int format, long unsigned int arg (arg 3)
drivers/char/drm/sis_mm.c:92: warning: unused variable `req'
drivers/char/drm/sis_mm.c:98: warning: implicit declaration of function `sis_malloc'
sound/core/info.c:195: warning: comparison of distinct pointer types lacks a cast
sound/core/info.c:230: warning: comparison of distinct pointer types lacks a cast
