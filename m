Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTKBRAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTKBRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 12:00:31 -0500
Received: from web40908.mail.yahoo.com ([66.218.78.205]:1366 "HELO
	web40908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261733AbTKBRAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 12:00:30 -0500
Message-ID: <20031102170029.59013.qmail@web40908.mail.yahoo.com>
Date: Sun, 2 Nov 2003 09:00:29 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: What do frame pointers do?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What exactly is the purpose of a frame pointer? As far back as I can remember, 2.4
and 2.6 kernels have supported something called a frame pointer, which slows down
the kernel slightly but supposedly outputs 'very useful debugging information.'
Unfortunately, it doesn't really explain what they are, and for the past few months,
I haven't seen any hacker gods asking for CONFIG_FRAME_POINTER=y, except for Russell
King, who wants them compiled for ARM processors for some reason (I grepped the
kernel source looking for answers and found a comment which implied this).

Does anyone know where I can find a good explanation of what they are and what they
do?

TIA

Brad Chapman

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
