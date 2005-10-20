Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbVJTPFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbVJTPFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbVJTPFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:05:37 -0400
Received: from khc.piap.pl ([195.187.100.11]:3332 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751604AbVJTPFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:05:36 -0400
To: Rudolf Polzer <debian-ne@durchnull.de>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
References: <20051018044146.GF23462@verge.net.au>
	<m37jcakhsm.fsf@defiant.localdomain>
	<20051018171645.GA59028%atfield-dt@durchnull.de>
	<m3fyqyhdm8.fsf@defiant.localdomain>
	<20051018204919.GA21286%atfield-dt@durchnull.de>
	<m3oe5l21rr.fsf@defiant.localdomain>
	<20051019132326.GA31526%atfield-dt@durchnull.de>
	<m3y84pjo9m.fsf@defiant.localdomain>
	<20051019202458.GA51688%atfield-dt@durchnull.de>
	<m3zmp52jyz.fsf@defiant.localdomain>
	<20051019231258.GA5035%atfield-dt@durchnull.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 20 Oct 2005 17:05:33 +0200
In-Reply-To: <20051019231258.GA5035%atfield-dt@durchnull.de> (Rudolf
 Polzer's message of "Thu, 20 Oct 2005 01:12:58 +0200")
Message-ID: <m3irvs9qki.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Polzer <debian-ne@durchnull.de> writes:

> We use a PS/2 port, so without a reboot, this would not work. IIRC 2.6
> kernels
> with keyboard support compiled into the kernel cannot be forced to re-detect
> the keyboard when the line was interrupted (which is a big problem with
> old KVM
> switches).

Must have been a different problem, just tried and the keyboard works fine.

But of course one can connect the "dongle" before rebooting. Dead keyboard
can force reboot as well, can't it?

> Of course, with USB keyboards this approach would work.

Would be less trivial.
-- 
Krzysztof Halasa
