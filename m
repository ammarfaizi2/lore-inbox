Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbSIZAiO>; Wed, 25 Sep 2002 20:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSIZAiO>; Wed, 25 Sep 2002 20:38:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9991 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261702AbSIZAiN>; Wed, 25 Sep 2002 20:38:13 -0400
Date: Thu, 26 Sep 2002 01:43:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Michel Eyckmans (MCE)" <mce@pi.be>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
Message-ID: <20020926014326.A26322@flint.arm.linux.org.uk>
References: <200209242242.g8OMgmvX008154@jebril.pi.be> <Pine.LNX.3.96.1020925134010.24336A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020925134010.24336A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Wed, Sep 25, 2002 at 01:46:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 01:46:18PM -0400, Bill Davidsen wrote:
> Have you tried running without X and using the serial port for other
> things, like ppp? The assumption is that this is a mouse issue, and I
> haven't run 2.5.38 long enough to swear that it isn't, but it might also
> be a serial issue. I would venture a guess that the major developers don't
> use serial much for anything.

It could be serial, especially as my big change went in back in .28.
It would also be worth checking that the port is actually detected
by the kernel; the kernel messages will give that information.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

