Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUBADs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 22:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUBADs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 22:48:26 -0500
Received: from mta04-svc.ntlworld.com ([62.253.162.44]:51722 "EHLO
	mta04-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265205AbUBADsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 22:48:25 -0500
Date: Sun, 1 Feb 2004 03:50:35 +0000
From: DaMouse Networks <damouse@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ 9: nobody cared ;_;
Message-Id: <20040201035035.600d2876@EozVul.WORKGROUP>
Organization: DaMouse Networks
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irq 9: nobody cared!
Call Trace:
 [<c010d5fe>] __report_bad_irq+0x2a/0x8b
 [<c010d6e8>] note_interrupt+0x6f/0x9f
 [<c010da06>] do_IRQ+0x161/0x192
 [<c0105000>] _stext+0x0/0x64
 [<c010bd64>] common_interrupt+0x18/0x20
 [<c010901e>] default_idle+0x0/0x2c
 [<c0105000>] _stext+0x0/0x64
 [<c0109047>] default_idle+0x29/0x2c
 [<c01090b0>] cpu_idle+0x33/0x3c
 [<c03b6850>] start_kernel+0x19e/0x1de
 [<c03b640e>] unknown_bootoption+0x0/0xfd
 
handlers:
[<c0207f37>] (acpi_irq+0x0/0x16)
Disabling IRQ #9

thats all i got, hope it helps.
