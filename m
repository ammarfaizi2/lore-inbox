Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVAERXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVAERXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVAERXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:23:08 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:64148 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S262182AbVAERWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:22:53 -0500
Date: Wed, 5 Jan 2005 18:22:46 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
In-Reply-To: <41DC2113.8080604@gmx.de>
Message-ID: <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
 <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
 <41DC2113.8080604@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:

> Martin Drab schrieb:
> Just to avoid confusion: If your bios does *not contain the fix, the
> kernel should fix it and above line should appear. (It does here with
> 2.6.10) So if it doesn't in your case (and your bios does not contain
> that fix), the detection code probably isn't enough. -> This should be
> fixed in kernel.
> 
> When you use a fixed bios though, above line should not appear, and your
> system should be stable.

Is there some other way to get to know whether BIOS contains the fix 
allready?

Martin

