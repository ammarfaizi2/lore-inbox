Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTHUFu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 01:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbTHUFu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 01:50:57 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:36494 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262474AbTHUFuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 01:50:40 -0400
Date: Thu, 21 Aug 2003 01:30:45 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 9/10 2.4.22-rc2 fix __FUNCTION__ warnings net/irda/irlan
Message-Id: <20030821013045.5020d8ff.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 irlan_client.c         |   50 +++++++++++++++++------------------
 irlan_client_event.c   |   65 ++++++++++++++++++++++-----------------------
 irlan_common.c         |   70 ++++++++++++++++++++++++-------------------------
 irlan_eth.c            |   16 +++++------
 irlan_event.c          |    4 +-
 irlan_filter.c         |    4 +-
 irlan_provider.c       |   30 ++++++++++-----------
 irlan_provider_event.c |   16 +++++------
 8 files changed, 127 insertions(+), 128 deletions(-)

http://www.vmlinuz.com.ar/slackware/patch/kernel/net.irda.irlan.patch
http://www.vmlinuz.com.ar/slackware/patch/kernel/net.irda.irlan.patch.asc

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
