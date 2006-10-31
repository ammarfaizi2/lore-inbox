Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161623AbWJaER5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161623AbWJaER5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161624AbWJaER5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:17:57 -0500
Received: from mail128.messagelabs.com ([216.82.250.131]:17084 "HELO
	mail128.messagelabs.com") by vger.kernel.org with SMTP
	id S1161623AbWJaER4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:17:56 -0500
X-VirusChecked: Checked
X-Env-Sender: E5739C@motorola.com
X-Msg-Ref: server-8.tower-128.messagelabs.com!1162268275!5580288!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [129.188.136.8]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Can't compile linux-2.6.10 on FC5
Date: Tue, 31 Oct 2006 12:17:51 +0800
Message-ID: <565F40B9893580489B94B8D324460AF4E9FF86@zmy16exm63.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can't compile linux-2.6.10 on FC5
thread-index: Acb8o4fjCCJIDATHRvm6KN9o0VJYkg==
From: "Sun Zongjun-E5739C" <E5739C@motorola.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I prepare to compile linux-2.6.10 on FC5. But it report the following
errors when compiling the function of show_regs defined
arch/i386/kernel/process.c

{standard input}: Assembler messages:
{standard input}: 797: Error: suffix or operands invalid for 'mov'
....

My GCC is 4.1, binutils is 2.16.91.0.6. It does not work too even after
I used CC=gcc32 make bzImage

I have searched it via Google. And found many such problems. How can fix
it?

Thanks very much for you kind support.

Best Regards
Zongjun
