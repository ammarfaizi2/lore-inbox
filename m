Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281925AbRKZQsA>; Mon, 26 Nov 2001 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281926AbRKZQru>; Mon, 26 Nov 2001 11:47:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281925AbRKZQri>; Mon, 26 Nov 2001 11:47:38 -0500
Subject: Re: Linux 2.4.16-pre1
To: david.lang@digitalinsight.com (David Lang)
Date: Mon, 26 Nov 2001 16:55:17 +0000 (GMT)
Cc: martin@cendio.se (Martin Persson), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111260616340.25678-100000@dlang.diginsite.com> from "David Lang" at Nov 26, 2001 06:26:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168P2L-0005fW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so all complaints about how the VM change should have waited until 2.5/2.6
> ignore the fact that the existing VM system was broken.

Not paticularly. The original VM was fixable enough to branch 2.5, then 
put the new VM in 2.5 and backport it without shipping two releases that
100% didnt actually work.

> more, don't gripe about the stable kernels not being perfect. It doesn't
> matter how many -rc kernels there are if most people wait until -final
> before doing their testing.

Thats why vendor kernels are generally a good idea for production setups.
Most vendors kernel trees have been beaten solidly for days with stress
testing and coverage test tools before they get put out
