Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRDXBJR>; Mon, 23 Apr 2001 21:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132674AbRDXBJG>; Mon, 23 Apr 2001 21:09:06 -0400
Received: from m28-mp1-cvx1b.col.ntl.com ([213.104.72.28]:15233 "EHLO
	[213.104.72.28]") by vger.kernel.org with ESMTP id <S132658AbRDXBIt>;
	Mon, 23 Apr 2001 21:08:49 -0400
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu>
	<m2k84jkm1j.fsf@boreas.yi.org.> <20010420190128.A905@bug.ucw.cz>
	<m2snj3xhod.fsf@bandits.org> <20010424021756.A931@pcep-jamie.cern.ch>
From: John Fremlin <chief@bandits.org>
Date: 24 Apr 2001 02:08:40 +0100
In-Reply-To: <20010424021756.A931@pcep-jamie.cern.ch>
Message-ID: <m2n197nlyf.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

[...]

> Are you sure?  A suspend takes about 5-10 seconds on my laptop.

You mean when you tell the apm driver from userspace to suspend?

> (It was noticably faster with 2.3 kernels, btw.  Now it spends a second
> or two apparently not noticing the APM event (though the BIOS is making
> the speaker beep), then syncing the disk, 

The BIOS got the event, problem is in BIOS surely?

[...]

-- 

	http://www.penguinpowered.com/~vii
