Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273302AbRI3K63>; Sun, 30 Sep 2001 06:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRI3K6T>; Sun, 30 Sep 2001 06:58:19 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:18118 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S273265AbRI3K6J>; Sun, 30 Sep 2001 06:58:09 -0400
Posted-Date: Sun, 30 Sep 2001 12:51:53 +0100 (WEST)
Date: Sun, 30 Sep 2001 13:02:21 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200109301102.NAA00919@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-ac18, many warnings __cpu_raise_softirq
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
While compiling 2.4.9-ac18, I get many warnings like :

In file included from /usr/src/kernel-sources-2.4.9-ac18/include/linux/netdevice.h:424,
                 from ip_sockglue.c:27:
 /usr/src/kernel-sources-2.4.9-ac18/include/linux/interrupt.h:77: 
 		warning: `__cpu_raise_softirq' redefined
 /usr/src/kernel-sources-2.4.9-ac18/include/asm/softirq.h:53:
		 warning: this is the location of the previous definition

---
Regards
		Jean-Luc
