Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUEJMmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUEJMmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUEJMmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:42:00 -0400
Received: from aun.it.uu.se ([130.238.12.36]:59813 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264677AbUEJMls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:41:48 -0400
Date: Mon, 10 May 2004 14:41:40 +0200 (MEST)
Message-Id: <200405101241.i4ACfeid029222@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.7.1 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.7.1 of perfctr, the Linux performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Version 2.7.1, 2004-05-10
- Updated the x86 and x86-64 drivers for the final version
  of the local APIC ownership API included in kernel 2.6.6.
  Perfctr and Oprofile can now coexist safely.

/ Mikael Pettersson
