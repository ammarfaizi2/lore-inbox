Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbTIHFAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 01:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTIHFAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 01:00:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:15555 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261952AbTIHFAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 01:00:30 -0400
Date: Sun, 7 Sep 2003 22:00:20 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309080500.h8850K5R008753@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 4 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/oss/pss.c:1004: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:191: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:640: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
sound/oss/pss.c:710: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)
