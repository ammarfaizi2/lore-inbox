Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbSJKMAE>; Fri, 11 Oct 2002 08:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262412AbSJKMAE>; Fri, 11 Oct 2002 08:00:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9234 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262411AbSJKMAD>; Fri, 11 Oct 2002 08:00:03 -0400
Date: Fri, 11 Oct 2002 13:05:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: serial cons prob on reboot in 2.5
Message-ID: <20021011130546.A8823@flint.arm.linux.org.uk>
References: <Pine.BSF.4.44.0210051202450.39858-100000@e0-0.zab2.int.zabbadoz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.BSF.4.44.0210051202450.39858-100000@e0-0.zab2.int.zabbadoz.net>; from bzeeb-lists@lists.zabbadoz.net on Sat, Oct 05, 2002 at 12:08:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 12:08:56PM +0000, Bjoern A. Zeeb wrote:
> when rebooting a 2.5 machine I only get crap on the serial console
> and nothing readable. Works fine while booting and running.

What console= arguments are you passing to the kernel?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

