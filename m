Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbTAGR7V>; Tue, 7 Jan 2003 12:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbTAGR7U>; Tue, 7 Jan 2003 12:59:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267532AbTAGR7T>;
	Tue, 7 Jan 2003 12:59:19 -0500
Date: Tue, 7 Jan 2003 10:04:39 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.54-bk1 unit. timer message
Message-ID: <Pine.LNX.4.33L2.0301071002560.2498-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is this one known?


Initializing CPU#0
Uninitialised tiimer!
This is warning.  Your computer is OK
function=0xc0126580, data=0x0
Call Trace:
[<c0125172>] .text.lock.ptrace+0x42/0x70
[<c0126580>] timer_cpu_notify+0x0/0xcd
[<c0125200>] check_timer_failed+0x60/0x190
[<c011eba8>] emit_log_char+0x1d8/0x230
[<c0132371>] proc_dma_open+0x11/0x20
[<c0105000>] +0x0/0x80

-- 
~Randy

