Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269146AbRGaBeY>; Mon, 30 Jul 2001 21:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269147AbRGaBeO>; Mon, 30 Jul 2001 21:34:14 -0400
Received: from rj.SGI.COM ([204.94.215.100]:32490 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269146AbRGaBeJ>;
	Mon, 30 Jul 2001 21:34:09 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, greg@kroah.com
Subject: Re: Support for serial console on legacy free machines 
In-Reply-To: Your message of "Mon, 30 Jul 2001 16:40:31 CST."
             <200107302240.f6UMeWg2001230@webber.adilger.int> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 11:33:38 +1000
Message-ID: <31754.996543218@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 16:40:31 -0600 (MDT), 
Andreas Dilger <adilger@turbolinux.com> wrote:
>What bothers me is that new systems don't have a serial port, and no ISA
>slots, so there is no hope of getting a "serial console" support without
>ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
>for early-boot debugging, so what else is left?

I briefly discussed this with the USB maintainers at the 2.5 kernel
developers conference.  They thought that a stripped down USB serial
console was possible, without full USB support.  Is that still the
case?

