Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUH1Ntr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUH1Ntr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUH1Ntr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:49:47 -0400
Received: from zero.aec.at ([193.170.194.10]:2308 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266686AbUH1Nti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:49:38 -0400
To: =?iso-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Voluntary Preempt P9 againstclean  2.6.8.1 -- on AMD64, compile
 failure
References: <2xSys-7h8-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 28 Aug 2004 15:49:30 +0200
In-Reply-To: <2xSys-7h8-11@gated-at.bofh.it> (Petter
 =?iso-8859-1?Q?Sundl=F6f's?= message of "Fri, 27 Aug 2004 19:20:08 +0200")
Message-ID: <m3vff3cqz9.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petter Sundlöf <petter.sundlof@findus.dhs.org> writes:

> On Debian-AMD64
> Applied
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> to a clean 2.6.8.1 (simply copied over my old .config). Patching went
> fine. Using gcc 3.3.4.


Looks like your tree is broken. Download a fresh tarball.
I tried to compile your configuration and it worked just fine.

-Andi

