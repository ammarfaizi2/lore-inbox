Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTFCIRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTFCIRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:17:23 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:5826 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264619AbTFCIRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:17:21 -0400
Date: Tue, 3 Jun 2003 11:30:32 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
To: linux-kernel@vger.kernel.org
Subject: Weird keyboard with 2.4.20 (NEW!)
In-Reply-To: <20030602162447.GD3237@gmx.de>
Message-ID: <Pine.LNX.4.53.0306031127540.7925@hosting.rdsbv.ro>
References: <3ED7BECC.1000109@g-house.de> <20030531151615.GA13051@sexmachine.doom>
 <1054570309.1208.8.camel@andyp.pdx.osdl.net> <20030602162447.GD3237@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I saw a problem with the keyboard and I want to tell my story.
Motherboards are EPOX with an Nvidia TNT2 card.
2 computers - not the same hard configuration.
>From time to time the keyboard goes crazy: I press A it gives me z, I
press ENTER it gives me n and so on.
After a while or with a reset, the problem is gone.
What can this be?
Thanks!


On Mon, 2 Jun 2003, Wiktor Wodecki wrote:

> On Mon, Jun 02, 2003 at 09:11:49AM -0700, Andy Pfiffer wrote:
> > On Sat, 2003-05-31 at 08:16, Konstantin Kletschke wrote:
> >
> > > Sometime a key is very fast repeated 10 to 20 times after pressed only
> > > one.
> >
> > I have seen this on one of two systems connected to a 4-port KVM
> > switch.  I started seeing it in 2.5.68 or 2.5.69.  The other system has
> > not demonstrated the super-fast repeat.
>
> I see this on my ibm thinkpad T20 with 2.5.69. I manually raised my
> kbdrate(1) settings and that helps. However when switching between X
> and text-consoles it gets worse after a while.
>
> --
> Regards,
>
> Wiktor Wodecki
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
