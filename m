Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbTLRLch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbTLRLch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:32:37 -0500
Received: from math.ut.ee ([193.40.5.125]:34028 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265095AbTLRLcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:32:33 -0500
Date: Thu, 18 Dec 2003 13:32:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
In-Reply-To: <20031205113619.A20371@lists.us.dell.com>
Message-ID: <Pine.GSO.4.44.0312181330150.5204-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > However, changing DISKSIG_BUFFER to DISK80_SIG_BUFFER causes the kernel to
> > > reboot the computer as soon as it starts booting.  Basically I select it
> > > in grub and the screen changes graphics mode and by the time it has
> > > finished the switch the computer reboots.

Same here - instant reboot when EDD is enabled. Do you need my config
also? The mainboard is Intel D815EEA2 with latest BIOS
(EA81520A.86A.0039.P21.0211061753).

-- 
Meelis Roos (mroos@linux.ee)

