Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbTBZVTq>; Wed, 26 Feb 2003 16:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBZVTq>; Wed, 26 Feb 2003 16:19:46 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:44237
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S268924AbTBZVTp>; Wed, 26 Feb 2003 16:19:45 -0500
Date: Wed, 26 Feb 2003 16:28:51 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Mikael Pettersson <mikpe@user.it.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] fix UP local APIC on SMP Athlon
In-Reply-To: <200302231638.h1NGcbTx009510@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0302251618310.32233-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Mikael Pettersson wrote:

> Tested on two UP_APIC Intel machines. I would appreciate testing on
> AMD, UP_IOAPIC machines, and UP-kernel-on-SMP-hardware.

It tested fine on a UP/IO-APIC AMD and on an SMP AMD, as well as on an SMP
Xeon P4, all of them running UP kernels. It also tested fine on the SMP 
AMD and Xeon, running SMP kernels. Sorry it took so long to reply, I 
couldn't reboot these machines right away. :-)

I'd say your patch is ready for inclusion in at least the -ac kernels.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.




