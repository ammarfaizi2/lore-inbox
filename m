Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUBUAYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUBUAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:24:20 -0500
Received: from m013-078.nv.iinet.net.au ([203.217.13.78]:2320 "EHLO
	mail.adixein.com") by vger.kernel.org with ESMTP id S261446AbUBUAYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:24:16 -0500
From: "Elliot Mackenzie" <macka@adixein.com>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Date: Sat, 21 Feb 2004 10:25:09 +1000
Keywords: macka@adixein.com
Message-ID: <001401c3f811$29a57e70$4301a8c0@waverunner>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20040220161139.3bd95852.rddunlap@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

c03e46c9 t do_initcalls, if I got the one you are looking for...

Cheers,
Elliot.


| Duh, I forgot.  Please look up these initcall addresses in your
| System.map file (or post it on the web or mail it).
|
| But that size=0xedeb0000 is a problem... just to figure out where
| it's coming from, using the initcall symbols.
<snip>

