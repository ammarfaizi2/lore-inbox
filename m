Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUAEN4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUAEN4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:56:05 -0500
Received: from hera.kernel.org ([63.209.29.2]:49586 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264147AbUAEN4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:56:02 -0500
Date: Mon, 5 Jan 2004 05:55:57 -0800
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200401051355.i05DtvgC020415@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.24 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.24-rc1 was released as 2.4.24 with no changes.


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

