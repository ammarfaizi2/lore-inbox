Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTJ3RNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTJ3RNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:13:04 -0500
Received: from team-server.ntb.ch ([146.136.1.32]:57553 "EHLO
	team-server.ntb.ch") by vger.kernel.org with ESMTP id S262669AbTJ3RND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:13:03 -0500
Message-ID: <001b01c39897$09e08aa0$b1248892@ntb.ch>
From: "Angelo Compagnoni" <acompagnoni@ntb.ch>
To: <linux-kernel@vger.kernel.org>
Subject: PCI-driver bursting to target
Date: Wed, 22 Oct 2003 14:21:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-OriginalArrivalTime: 30 Oct 2003 17:13:00.0695 (UTC) FILETIME=[124B4270:01C39F09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is there any feature in the kernel source, that supports burst >writes and
reads to a target?
>The driver I have works for single data transfer with the methods
>writel(b,addr) and readl(addr).
>I need the burst mode for my diploma thesis.
>Thank you for help.
>
>I wish to be personally CC'ed the answers/comments posted to the >list in
response to my posting.

