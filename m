Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287409AbRL3Nnd>; Sun, 30 Dec 2001 08:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287399AbRL3NnN>; Sun, 30 Dec 2001 08:43:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31239 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287414AbRL3NnH>; Sun, 30 Dec 2001 08:43:07 -0500
Subject: Re: SIS-Driver
To: TRTracer@web.de (Tobias Reinhard)
Date: Sun, 30 Dec 2001 13:53:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004801c19133$9bc91210$0dfda8c0@mausi> from "Tobias Reinhard" at Dec 30, 2001 02:12:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KgPQ-0001Fb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What am I doing wrong, or is that a bug? I solved it by setting up a Kernel
> with all SIS-DRM included, compile X and then removed them. ATM I am unable
> to test if the SIS-DRM really runs with that configuration...

If X is poking around in the kernel configuration and requires it built in
then report the problem to the XFree86 people.

For the SiS DRM you do need SiS framebuffer currently
