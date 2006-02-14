Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWBNOrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWBNOrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBNOrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:47:11 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:30457 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030590AbWBNOrJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:47:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n9U4OD4ayCmO0UIwIVgaC5CcBLBOq6tR9OLdzjQhlg500pfVVOrOBP3QHYiu3aVAPp6/dMh0e/8Y+GehVPMi699PiZcGzUjqfZSC9YzMGZ6ro9pivMO5qnDhNXdzoCFzmQZzo2n1UmGSSAfDXIgPY5w40mPNKNwbm2Uf1e/2OAE=
Message-ID: <7c3341450602140647s6acad767k@mail.gmail.com>
Date: Tue, 14 Feb 2006 14:47:08 +0000
From: Nick Warne <nick@linicks.net>
Reply-To: Nick Warne <nick@linicks.net>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Subject: Re: Random reboots
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060214132904.GI16566@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060213210435.GC16566@tau.solarneutrino.net>
	 <20060213211044.066CE5E401E@latitude.mynet.no-ip.org>
	 <20060213212243.GE16566@tau.solarneutrino.net>
	 <7c3341450602131332x2fcd7d8co@mail.gmail.com>
	 <20060213213929.GG16566@tau.solarneutrino.net>
	 <20060213214956.GH16566@tau.solarneutrino.net>
	 <20060214085446.GH3209@harddisk-recovery.com>
	 <20060214132904.GI16566@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > During the years I've had this machine, I've experienced at least 10-15
> strange kernel bugs that only happened on this machine.  Each and every
> time I was *convinced* that the hardware was at fault (and people on the
> mailing list suggested it) until either a kernel came out that fixed the
> problem or a kernel developer positively identified it as a kernel
> problem and eventually fixed it.  This machine just seems to be a magnet
> for kernel bugs.

OK, reference to the similar issues I have seen on 2 boxes here at
work (ukqip01 & 02), I have dug out an old mail I sent to colleague
after the 3 time it happened to me:



"In fact it has happened to both of them now.  UKQIP01 restarted once
(about 3 years) ago in the middle of the night, then about 6 months
later UKQIP02 did the same.  If you remember I then replaced memory
from 512 to 1024.

Now UKQIP02 has done it again.

I am not too concerned, as twice in 3 years is not really a problem
(yet), but I am more curious as to why because I want to fix it.

It also only happens in the dead twilight hours too.

I will look at running memtest, but as you know that takes hours and
the box will have to taken down for the duration.

I will keep you informed."



This was last September 2005 - the time it happened before that was
Janurary 2005.

Very strange.

Nick
