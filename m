Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbTLNE3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 23:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbTLNE3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 23:29:40 -0500
Received: from smtp-out.attla.net.ar ([200.61.58.140]:24903 "EHLO
	pop3.attla.net.ar") by vger.kernel.org with ESMTP id S265342AbTLNE3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 23:29:38 -0500
Message-ID: <006501c3c1fa$e1fb8d90$0200000a@heretic>
From: "Alexis" <alexis@attla.net.ar>
To: <linux-kernel@vger.kernel.org>
Subject: modules in 2.6.0-test11
Date: Sun, 14 Dec 2003 01:29:36 -0300
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

Ive compilled and installed 2.6.0-test11 on redhat 8 in order to filter
packets based on some patterns in layer 7 (l7-filter.sourceforge.net)

So, ive installed the kernel, and installed module-init-tools-0.9.14 too.

The kernel works fine, all modules too but i have to insert them with insmod
or modprobe, i cannot make that modules became loaded automatically.

Ive compiled the kernel with CONFIG_KMOD=Y

any help?

Thanks



--
A man in black on a snow white horse,
A pointless life has run its course,
The red rimmed eyes, the tears still run
As he fades into the setting sun


