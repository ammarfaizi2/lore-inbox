Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUAEM2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUAEM2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:28:39 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12699 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264245AbUAEM2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:28:37 -0500
Date: Mon, 5 Jan 2004 10:18:35 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.24-rc1
Message-ID: <Pine.LNX.4.58L.0401051003341.1188@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This release fixes a few critical problems in 2.4.23, including fixes
for two security bugs.

Upgrade is recommended.

Detailed changelog follows


Summary of changes from v2.4.23 to v2.4.24-rc1
============================================

<bjorn.helgaas:hp.com>:
  o Fix 2.4 EFI RTC oops

<marcelo.tosatti:cyclades.com>:
  o Andrea Arcangeli: malicious users of mremap() syscall can gain priviledges

<marcelo:logos.cnet>:
  o Harald Welte: Fix ipchains MASQUERADE oops
  o Change EXTRAVERSION to 2.4.24-rc1

<trini:mvista.com>:
  o /dev/rtc can leak parts of kernel memory to unpriviledged users

Jean Tourrilhes:
  o IrDA kernel log buster

