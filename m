Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVCOM6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVCOM6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVCOM6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:58:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:6327 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261208AbVCOM6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:58:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.56275.509686.163514@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 13:57:55 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: enabling IOAPIC on C3 processor? (how to investigate hangs without nmi watchdog)
In-Reply-To: <5a2cf1f605031504527979cef4@mail.gmail.com>
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
	<16950.54895.527127.21123@alkaid.it.uu.se>
	<5a2cf1f605031504527979cef4@mail.gmail.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste writes:
 > So if I don't have APIC, that means I cannot use nmi_watchdog to
 > investigate the problem, right?

Correct.

 > Do I have any alternative to investigate this hang or should I just
 > give up and smash my board?

I can't help you with that one.
