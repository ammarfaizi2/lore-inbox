Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbTHUEfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTHUEfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:35:08 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:28175 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262401AbTHUEfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:35:04 -0400
Date: Thu, 21 Aug 2003 01:29:32 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2/10 2.4.22-rc2 fix __FUNCTION__ warnings drivers/hotplug
Message-Id: <20030821012932.7179f30c.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 cpqphp.h           |    6 ++--
 cpqphp_core.c      |   30 +++++++++++------------
 cpqphp_ctrl.c      |   68 ++++++++++++++++++++++++++---------------------------
 cpqphp_nvram.c     |    2 -
 cpqphp_pci.c       |   12 ++++-----
 pci_hotplug_core.c |    2 -
 pci_hotplug_util.c |    2 -
 7 files changed, 61 insertions(+), 61 deletions(-)

http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch
http://www.vmlinuz.com.ar/slackware/patch/kernel/drivers.hotplug.patch.asc

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
