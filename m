Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278591AbRJ1Rb6>; Sun, 28 Oct 2001 12:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278597AbRJ1Rbs>; Sun, 28 Oct 2001 12:31:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21773 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278592AbRJ1Rb3>; Sun, 28 Oct 2001 12:31:29 -0500
Subject: Re: [PATCH] Avoid a race in complete_change_console()
To: pf-kernel@mirkwood.net (PinkFreud)
Date: Sun, 28 Oct 2001 17:38:00 +0000 (GMT)
Cc: christopher.j.ahna@intel.com (Chris Ahna), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0110281202130.15433-100000@eriador.mirkwood.net> from "PinkFreud" at Oct 28, 2001 12:25:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xtsm-0008Oa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Chris, THANK YOU!  I've been having a problem on my SMP system for months
> now, where if I started X, switched to a text console, and then back to X,
> the system would lock up.  Your patch actually fixed it!
> 
> Alan, could you please make sure this patch makes it into the kernel?

Already in my tree
