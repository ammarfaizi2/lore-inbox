Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTITP1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 11:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTITP1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 11:27:24 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:11155 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261899AbTITP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 11:27:24 -0400
Message-ID: <001901c37f8b$ba870b60$7d656b81@sigma>
From: "Anoop" <anoopr@myrealbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Framebuffer problem in 2.6.0 test5
Date: Sat, 20 Sep 2003 10:27:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a problem with the framebuffer device. During boot, the boot
parameter "vga=791" results in a horribly distorted boot up screen. I doesnt
happen with "vga=normal". I've compiled the kernel with the same options as
2.4.18 and it works in that. I wont be able to see anything at allduring
boot. Any Ideas?
Thaks,
Anoop

