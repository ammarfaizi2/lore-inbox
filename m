Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311144AbSCMTzC>; Wed, 13 Mar 2002 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311136AbSCMTym>; Wed, 13 Mar 2002 14:54:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18694 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311132AbSCMTyg>; Wed, 13 Mar 2002 14:54:36 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 13 Mar 2002 20:06:49 +0000 (GMT)
Cc: Martin.Wirth@dlr.de (Martin Wirth),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.3.96.1020313143751.4797A-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Mar 13, 2002 02:41:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lF1N-0007Iv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me mention this again... The IBM release of NGPT states that Linus has
> approved the inclusion of the NGPT patches in the mainline kernel. Will
> this be in 2.4.19 release? I've been running 2.4.17 for NGPT, haven't
> tried 2.4.19 other than to see the patch didn't apply).

2.5 but hopefully it will get backported as it proves solid and the API
is fixed
