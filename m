Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLZRr3>; Thu, 26 Dec 2002 12:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLZRr3>; Thu, 26 Dec 2002 12:47:29 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:26057 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S263280AbSLZRr2>; Thu, 26 Dec 2002 12:47:28 -0500
Date: Thu, 26 Dec 2002 10:55:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Randolph Chung <randolph@tausq.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, parisc-linux@parisc-linux.org,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [parisc-linux] Generic RTC driver in 2.4.x?
Message-ID: <20021226175529.GB6867@opus.bloom.county>
References: <Pine.GSO.4.21.0212241451450.1821-100000@vervain.sonytel.be> <20021224235147.GT19331@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021224235147.GT19331@tausq.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 03:51:47PM -0800, Randolph Chung wrote:
> > AFAIK the generic RTC driver is used on PA-RISC, PPC, and m68k.
> > 
> > Are you interested in a backport to 2.4.x?
> 
> On parisc we already have a version of the generic RTC driver in our
> 2.4 tree. If there's something more "official" or common we can adopt
> that version. 

Similarly, PPC has had it's own 'generic' RTC driver in the kernel for
ages, so there's no pressing need, but if the 2.5 version makes its way
back into 2.4 (as the 2.5 version has some minor changes needed for
everyone which weren't in the 2.4 m68k version), we can easily switch to
that version.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
