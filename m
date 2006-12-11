Return-Path: <linux-kernel-owner+w=401wt.eu-S1762680AbWLKJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762680AbWLKJ3E (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762683AbWLKJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:29:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51945 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762680AbWLKJ3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:29:01 -0500
Message-Id: <20061211091850.PS6310420000@infradead.org>
Date: Mon, 11 Dec 2006 07:18:50 -0200
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] V4L/DVB fix
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 'master' from:
        git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

It fixes a breakage when compiling on ia64.

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/video/usbvision/usbvision-i2c.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

