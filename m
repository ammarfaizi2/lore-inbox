Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJRJm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTJRJm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 05:42:28 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:26249 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S261188AbTJRJm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 05:42:28 -0400
Message-ID: <00b801c3955c$7e623100$0514a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: <linux-kernel@vger.kernel.org>
Subject: HighPoint 374
Date: Sat, 18 Oct 2003 11:44:58 +0200
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

What's the current status of HPT 374 support? Is it working in any kernel
version?

I know HP provides binaries, but that's no good, I need to use other kernel
builds.

2.4.20-8 detects the card and provides the devices but data corruptions
happens all the time. Using the HP drivers everything works fine (note that
access is via /dev/sd* instead of /dev/hd*)...except that I can't replace
the kernel.

Thanks.

