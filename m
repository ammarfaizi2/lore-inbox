Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTI1L5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 07:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTI1L5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 07:57:47 -0400
Received: from res1.isp.contactel.cz ([212.65.193.165]:55512 "EHLO
	res.isp.contactel.cz") by vger.kernel.org with ESMTP
	id S262544AbTI1L5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 07:57:46 -0400
Date: Sun, 28 Sep 2003 13:57:42 +0200
From: Marcel Sebek <sebek64@post.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-t5-mm4 sch_generic assertion failed
Message-ID: <20030928115742.GA11934@penguin.penguin>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following message prints kernel 2.6.0-t5-mm4 while
disconnecting from Internet (poff):

KERNEL: assertion (dev->qdisc_list == NULL) failed at net/sched/sch_generic.c(530)

Vanilla 2.6.0-test5 doesn't have this behavior.


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

