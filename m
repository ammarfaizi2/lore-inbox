Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269737AbUICSed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269737AbUICSed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269704AbUICSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:34:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21889 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269519AbUICSbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:31:21 -0400
Date: Fri, 3 Sep 2004 14:31:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Need to configure AT/LANTIC NE2000 ethernet
Message-ID: <Pine.LNX.4.53.0409031427100.7534@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anybody know where Donald Becker's atlantic.c program is??
I modified ne.c to recognize a (ZIATEC) card, the correct IRQ was
found, etc. Linux is perfectly happy.... but the board
doesn't send or receive anything. Probably the AUI isn't
turned on.

ZIATEC seems to have been gobbled up and I need to replace the
home-brew software in about 1000 systems with Linux.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

