Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265697AbSKATYq>; Fri, 1 Nov 2002 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265717AbSKATYq>; Fri, 1 Nov 2002 14:24:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7944 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265697AbSKATYp>; Fri, 1 Nov 2002 14:24:45 -0500
Date: Fri, 1 Nov 2002 19:31:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021101193112.B26989@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211011439420.6949-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211011439420.6949-100000@serv>; from zippel@linux-m68k.org on Fri, Nov 01, 2002 at 02:50:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, next problem.

A "hex" config entry under the old config language used to omit the "0x"
prefix, requiring it to be added by whatever used it.  Kconfig adds the
"0x" prefix, thereby causing errors.

Is this difference intentional?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

