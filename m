Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265210AbSJWWRt>; Wed, 23 Oct 2002 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265254AbSJWWRs>; Wed, 23 Oct 2002 18:17:48 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:41696 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S265210AbSJWWRr>; Wed, 23 Oct 2002 18:17:47 -0400
From: jordan.breeding@attbi.com
To: linux-kernel@vger.kernel.org
Subject: question about nmi_watchdog boot parameter
Date: Wed, 23 Oct 2002 22:23:52 +0000
X-Mailer: AT&T Message Center Version 1 (Aug 12 2002)
Message-Id: <20021023222353.LFDW28719.rwcrmhc52.attbi.com@rwcrwbc58>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  Does anyone have any clues as to why nmi_watchdog=1 
fails to set itself up properly while nmi_watchdog=2 
seems to force itself to work under all 2.4.x and 2.5.x 
kernels on Dual AMD hardware?  If so does anyone have 
any ideas about how to fix it?  Thanks.

Jordan
