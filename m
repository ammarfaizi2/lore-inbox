Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSGOKOF>; Mon, 15 Jul 2002 06:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSGOKOE>; Mon, 15 Jul 2002 06:14:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15108 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317416AbSGOKOD>; Mon, 15 Jul 2002 06:14:03 -0400
Date: Mon, 15 Jul 2002 11:16:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Sailer <sailer@scs.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac3
Message-ID: <20020715111656.C13277@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz> <m2n0svr42e.fsf@best.localdomain> <1026584861.13886.27.camel@irongate.swansea.linux.org.uk> <m265zj9zxn.fsf@best.localdomain> <20020713205422.E25995@flint.arm.linux.org.uk> <1026728020.2365.23.camel@watermelon.scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1026728020.2365.23.camel@watermelon.scs.ch>; from sailer@scs.ch on Mon, Jul 15, 2002 at 12:13:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 12:13:40PM +0200, Thomas Sailer wrote:
> The point is that frequency scaling is normally used with voltage
> scaling. And lowering the voltage decreases the maximum frequency
> roughly linearly, while the dynamic power consumption decreases
> quadratically with voltage.

Yes, but there are some systems out there where it is advantageous to
use frequency scaling on hardware that supports it, without supporting
voltage scaling.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

