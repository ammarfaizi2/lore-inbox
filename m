Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTG0Cbv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 22:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270652AbTG0Cbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 22:31:51 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:653
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270651AbTG0Cbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 22:31:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: BCM4401 module success
Date: Sun, 27 Jul 2003 12:51:13 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271251.13573.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test1 and test1-mm2 b44 ethernet modules fail to work with the following 
card:

Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 1).

For those struggling with this, please download and patch jgarzik's latest 
netdrv patchkit available at

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/

which fixed it for me and it works flawlessly now.

Thanks
Con

