Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUF3JrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUF3JrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUF3JrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:47:10 -0400
Received: from [194.243.27.136] ([194.243.27.136]:12301 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S266604AbUF3JrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:47:09 -0400
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(213.140.22.76):. Processed in 0.051188 secs)
Date: Wed, 30 Jun 2004 11:51:21 +0200
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: bttv error: vmalloc_32(8519680) failed
Message-Id: <20040630115121.0417918b.devel@integra-sc.it>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
on my AMD XP+3000 with kernel 2.4.22 and bttv driver ver. 0.7.107 i have 16 devices video grabber /dev/video0-->/dev/video15. If i start programs that load images from the device /dev/video14 and /dev/video15 i receive this error:
bttv: vmalloc_32(8519680) failed

Any ideas
