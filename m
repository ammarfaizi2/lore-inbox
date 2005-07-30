Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVG3H4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVG3H4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 03:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVG3H4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 03:56:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30994 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263006AbVG3H4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 03:56:03 -0400
Date: Sat, 30 Jul 2005 08:55:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S3 resume and serial console..
Message-ID: <20050730085558.A7770@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Airlie <airlied@linux.ie>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0507300301370.13092@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507300301370.13092@skynet>; from airlied@linux.ie on Sat, Jul 30, 2005 at 03:03:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 03:03:24AM +0100, Dave Airlie wrote:
> Okay I'm really trying here but my PC really hates me :-)
> 
> I've set up an i865 machine with a serial console, and on-board graphics
> (also have radeon/MGA AGP..) and in an effort to try and figure out some
> more about suspend /resume to RAM..
> 
> However now the  serial port doesn't come back after resume, I just get
> garbage sent out on it ...
> 
> Anyone any ideas?

Not without some information such as the kernel messages right up to
the failure point, kernel version and a description of the hardware.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
