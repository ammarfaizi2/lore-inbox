Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131839AbRBKDrq>; Sat, 10 Feb 2001 22:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131858AbRBKDrg>; Sat, 10 Feb 2001 22:47:36 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:52234 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131839AbRBKDrY>; Sat, 10 Feb 2001 22:47:24 -0500
Date: Sat, 10 Feb 2001 19:47:20 -0800
Message-Id: <200102110347.f1B3lK224712@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Nathan Neulinger <nneul@umr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with adding starfire driver to kernel 2.2.18
X-Newsgroups: cs.lists.linux-kernel
In-Reply-To: <cs.lists.linux-kernel/3A85C4A9.8CAD6466@umr.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001 16:46:01 -0600, Nathan Neulinger <nneul@umr.edu> wrote:

> Any ideas on how I can correct this symptom?

This seems to be Donald Becker's driver, right? Please try with the
starfire driver for 2.2.x I posted a few hours ago to the list. If you
don't have it, contact me privately and I'll resend it to you.

Becker's PCI detection code is known to have, well, "issues".

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
