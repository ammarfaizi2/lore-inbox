Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRHPWk0>; Thu, 16 Aug 2001 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRHPWkQ>; Thu, 16 Aug 2001 18:40:16 -0400
Received: from [209.10.41.242] ([209.10.41.242]:56504 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268934AbRHPWkA>;
	Thu, 16 Aug 2001 18:40:00 -0400
Subject: Re: Red Hat precompiled kernels and the BreezeNet-driver
To: pawal@blipp.com (Patrik Wallstrom)
Date: Thu, 16 Aug 2001 23:42:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108170028100.5950-100000@vic20.blipp.com> from "Patrik Wallstrom" at Aug 17, 2001 12:36:29 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XVqG-0006Eq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> crashed on me, and I couldn't understand why since I had reports of others
> using it. Today I compiled 2.4.9 myself and right after installed the
> driver, and it immediately!
> 
> What exactly differs the Red Hat kernels from any original compiled
> kernel, and so much that this driver crashes the system?

At a guess the 2.4.9 updates to the wireless drivers made a difference for
your card. But thats a guess
