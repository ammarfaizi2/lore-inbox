Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265100AbRGENBa>; Thu, 5 Jul 2001 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbRGENBU>; Thu, 5 Jul 2001 09:01:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54279 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265100AbRGENBM>; Thu, 5 Jul 2001 09:01:12 -0400
Subject: Re: Kernel HOWTO update?
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Thu, 5 Jul 2001 14:00:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), spstarr@sh0n.net (Shawn Starr),
        bri@cs.uchicago.edu, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010705132933.00ab7d90@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Jul 05, 2001 01:31:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15I8k2-0002Wj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This isn't true anymore unless your using an older version of LILO.
> >For a large number of BIOSes out there it is still true
> Is this still true if you use the lba32 option in lilo.conf?

lba32 requires bios support - which is common, and working bios support which
is slightly less common on older boxes
