Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbRENEpc>; Mon, 14 May 2001 00:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbRENEpW>; Mon, 14 May 2001 00:45:22 -0400
Received: from 204-118-157-8.aculink.net ([204.118.157.8]:19985 "EHLO
	ganymede.aculink.net") by vger.kernel.org with ESMTP
	id <S261296AbRENEpO>; Mon, 14 May 2001 00:45:14 -0400
Date: Sun, 13 May 2001 22:46:57 -0600
Message-Id: <200105140446.f4E4kv104196@cdm01.deedsmiscentral.net>
X-no-archive: yes
From: SoloCDM <deedsmis@aculink.net>
Subject: IRQ Sharing
Reply-To: <deedsmis@aculink.net>, <linux-kernel@vger.kernel.org>
To: Linux-Kernel (Majordomo) <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully someone knows of the following problem and email's the
answer to <mailto:cdm@aculink.net?subject=Re:%20IRQ%20Sharing>,
because my mailing list address is blocked with 12,000 messages.
A solutions is in the workings.

I received a very long delay from a repeated "lost interrupt"
output error message to the console from both hdc and hdd drives.
The default kernel installation doesn't recognize two drives using
the same IRQ with Kernel 2.4.3-20 (at least that's what I gathered
from reading some documentation).

A 420Mb Conner drive is sharing an IRQ with a CD-ROM drive in the
second port on an EIDE controller card.  What needs to be changed
in the Kernel to solve this problem?

It's not necessary to abide by the below attached "Note:" (it's a
standard attachment).  The first paragraph address is sufficient
enough for *my* messages.

Note: When you reply to this message, please include the mailing
      list/newsgroup address and my email address in To:.

*********************************************************************
Signed,
SoloCDM
