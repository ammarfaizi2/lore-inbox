Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbSJWIwQ>; Wed, 23 Oct 2002 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbSJWIwQ>; Wed, 23 Oct 2002 04:52:16 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:30613 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id <S262906AbSJWIwP>;
	Wed, 23 Oct 2002 04:52:15 -0400
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15798.25662.10306.174579@mercury.home.hindley.uklinux.net>
Date: Wed, 23 Oct 2002 09:56:30 +0100 (BST)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Lockups in 2.4.19 -- suggestions please
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been getting recurrent lockups with 2.4.19. Usually when the
machine is idle and unattended. Often 10/day!!

Logs are always empty, SysRq unresponsive. Have rigged a serial
console - empty too.

Can I have some suggestions on how to get useful information for
debugging, either provoke/log an oops or get an eip?

CPU is K6, so APIC->NMI is not an option.

Have installed kdb, but cannot break in with that either.

Any suggestions?

Thanks,

Mark
