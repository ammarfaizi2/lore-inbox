Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbTIDVWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbTIDVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:22:43 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:34831 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S265546AbTIDVWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:22:40 -0400
Message-ID: <000c01c3732a$3d2f5a40$0500000a@bp>
From: "Brad Parker" <lkml@ro0tsiege.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.22 and below natsemi driver not working
Date: Thu, 4 Sep 2003 16:19:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an HP Pavilion ze4145 notebook and it has a National Semiconductor
DP83815 chip in it. The NIC works fine in other OS's but under Linux (Debian
3.0) with any kernel version, I get "init_module: No such device", and the
usual errors about insmod failing.

The only thing out of the ordinary in lspci is "Subsystem: Unknown device
3c08:2400".

What's wrong?


