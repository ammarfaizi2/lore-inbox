Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTEEESZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTEEESZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:18:25 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:10117
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S261889AbTEEESZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:18:25 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69 - ACPI + PCMCIA = problems in boot
Date: Sun, 4 May 2003 21:51:57 -0600
Message-Id: <20030505034241.M9880@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 200.67.170.154 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi:

  I have problems when boot with ACPI, after put the ACPI=off, and not boot
with PCMCIA in kernel, out my PCMCIA card and boot OK, both when in PCMCIA
card in my notebook not driver found.

  try with driver xirc2ps_cs.ko is the same problem not working my PCMCIA card
 
  PCMCIA card is XIRCOM_CB 32bits, try the compile module the kernel 2.4.20 in
kernel 2.5.69  I am have is the same problems, maybe problems with IRQs.

  Helpme please

  Regards. 
