Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVCTUvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVCTUvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVCTUvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 15:51:13 -0500
Received: from ctv-217-147-43-176.init.lt ([217.147.43.176]:58033 "EHLO
	buakaw.homelinux.net") by vger.kernel.org with ESMTP
	id S261255AbVCTUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 15:51:11 -0500
X-Antivirus-MYDOMAIN-Mail-From: buakaw@buakaw.homelinux.net via buakaw
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.63185 secs Process 12515)
Message-ID: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>
Date: Sun, 20 Mar 2005 22:51:08 +0200 (EET)
Subject: 
From: buakaw@buakaw.homelinux.net
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the system become very laggy.
i use kernel 2.6.10/2.6.11.3 on p4 2.8, msi915p, 3 x 3com905 boomerang.
and the cpu usage normally be about 12% and after something happens it
boost to 100% and it is used mostly by ksoftirqd/0, and a little bit by 
migration/0 and event/0. and in syslog i found thies lines

Mar 20 22:21:09 buakaw kernel: printk: 5543 messages suppressed.
Mar 20 22:21:09 buakaw kernel: dst cache overflow

what can cause this?


