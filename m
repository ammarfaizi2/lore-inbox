Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268230AbTBYRl5>; Tue, 25 Feb 2003 12:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbTBYRl5>; Tue, 25 Feb 2003 12:41:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53509 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268230AbTBYRly>; Tue, 25 Feb 2003 12:41:54 -0500
Date: Tue, 25 Feb 2003 17:52:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vherva@twilight.cs.hut.fi, mikael.starvik@axis.com,
       linux-kernel@vger.kernel.org, tinglett@vnet.ibm.com
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225175204.B21014@flint.arm.linux.org.uk>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	vherva@twilight.cs.hut.fi, mikael.starvik@axis.com,
	linux-kernel@vger.kernel.org, tinglett@vnet.ibm.com
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk> <20030225083811.797fbce6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225083811.797fbce6.rddunlap@osdl.org>; from rddunlap@osdl.org on Tue, Feb 25, 2003 at 08:38:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 08:38:11AM -0800, Randy.Dunlap wrote:
> I'm just guessing that it will be difficult to convince you otherwise,
> but I think you are missing the point of this.  It's not for someone
> who already has scripts to handle this or already uses 3+ commands
> to handle it every time that they build a new kernel.  It's for
> people who are less organized than you are -- gosh, maybe even
> for Linux users.

Well, rather than creating yet another archive system, maybe we should
just tar the lot up and make all boot loaders aware of the tar format?
After all, everyone understands tar and .debs better than RPMs, don't
they?

8-)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

