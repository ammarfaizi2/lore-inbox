Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTHUEjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbTHUEhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:37:17 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:6923 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262411AbTHUEfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:35:24 -0400
Date: Thu, 21 Aug 2003 01:30:05 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 5/10 2.4.22-rc2 fix __FUNCTION__ warnings drivers/net/irda
Message-Id: <20030821013005.09983219.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 act200l.c  |   14 +++++++-------
 irda-usb.c |    4 ++--
 ma600.c    |   28 ++++++++++++++--------------
 mcp2120.c  |    6 +++---
 nsc-ircc.c |    2 +-
 5 files changed, 27 insertions(+), 27 deletions(-)

http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.net.irda.patch
http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.net.irda.patch.asc

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
