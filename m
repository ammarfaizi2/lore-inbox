Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRKDUgn>; Sun, 4 Nov 2001 15:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKDUgd>; Sun, 4 Nov 2001 15:36:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51976 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278810AbRKDUgU>; Sun, 4 Nov 2001 15:36:20 -0500
Subject: Re: linux-2.2.20a and gcc 3.0 ?
To: f5ibh@db0bm.ampr.org (f5ibh)
Date: Sun, 4 Nov 2001 20:38:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111042026.fA4KQ0m01876@db0bm.ampr.org> from "f5ibh" at Nov 04, 2001 09:26:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160U2P-0002yH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is 2.2.20 supposed to works when compiled with gcc-3.0.2 ?
> It boots, but I have some missing symbols while loading some modules.
> The same config works fine with gcc-2.95.4

Use egcs-1.1.2 or gcc 2.95.[3,4]

gcc 3.0 is not supported in 2.2, and there are no plans to do so
