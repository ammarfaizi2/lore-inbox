Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264980AbSKAMqE>; Fri, 1 Nov 2002 07:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264982AbSKAMqE>; Fri, 1 Nov 2002 07:46:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:786 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264980AbSKAMqD>; Fri, 1 Nov 2002 07:46:03 -0500
Date: Fri, 1 Nov 2002 12:52:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021101125226.B16919@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210311452531.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210311452531.13258-100000@serv>; from zippel@linux-m68k.org on Thu, Oct 31, 2002 at 03:43:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 03:43:26PM +0100, Roman Zippel wrote:
> On Thu, 31 Oct 2002, Matthew Wilcox wrote:
> > I'm just looking over the new arch/parisc/Kconfig trying to make sure that
> > it got translated correctly, but I can't find any documentation.
> 
> http://www.xs4all.nl/~zippel/lc/

Is there a tool to convert _a_ Config.in to a Kconfig?  lkcc doesn't
seem to do it - it wants to do thw hole lot, which isn't very useful
when you've got half a tree that's converted and many Config.in files
that contain updates that aren't in Kconfig.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

