Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUDKHrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 03:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUDKHrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 03:47:47 -0400
Received: from server8.totalchoicehosting.com ([216.180.241.250]:42912 "EHLO
	server8.totalchoicehosting.com") by vger.kernel.org with ESMTP
	id S262273AbUDKHrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 03:47:46 -0400
From: Michael Wu <flamingice@sourmilk.net>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] adm8211 driver
Date: Sun, 11 Apr 2004 03:47:26 -0400
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404110347.27632.flamingice@sourmilk.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server8.totalchoicehosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - sourmilk.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a driver for the adm8211 802.11b chipset.

http://aluminum.sourmilk.net/adm8211/adm8211-20040411.tar.bz2

It's only for 2.6.x kernels, and it's not quite finished yet. It should mostly 
work for infrastructure and monitor modes, but adhoc and WEP don't work yet. 
Should work for the average wireless network though.

Thanks to Jouni Malinen for starting this driver, Jerritt Collord for telling 
me about his driver, and David Young for his netbsd driver I used as a 
reference.

Please test and see if it works for you.

I'm not subscribed to this list, so please CC.

- Michael Wu
