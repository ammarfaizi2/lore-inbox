Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265749AbSKAU3V>; Fri, 1 Nov 2002 15:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSKAU3V>; Fri, 1 Nov 2002 15:29:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10761 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265749AbSKAU3U>; Fri, 1 Nov 2002 15:29:20 -0500
Date: Fri, 1 Nov 2002 20:35:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
Message-ID: <20021101203546.C26989@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021101125226.B16919@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211011439420.6949-100000@serv> <20021101193112.B26989@flint.arm.linux.org.uk> <20021101203033.GA5773@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021101203033.GA5773@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Nov 01, 2002 at 01:30:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 01:30:33PM -0700, Tom Rini wrote:
> On a related question, can we now have 'UL', etc in a hex statement /
> question?

No thanks - that'll stop it being used in linker scripts.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

