Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130186AbRCHXTL>; Thu, 8 Mar 2001 18:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130261AbRCHXTB>; Thu, 8 Mar 2001 18:19:01 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:28654
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S130186AbRCHXSs>; Thu, 8 Mar 2001 18:18:48 -0500
Date: Thu, 8 Mar 2001 16:16:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Cole <scole@lanl.gov>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] remove CONFIG_NCR885E from Configure.help
Message-ID: <20010308161639.A16013@opus.bloom.county>
In-Reply-To: <01030808522000.01048@spc.esa.lanl.gov> <Pine.LNX.4.05.10103081720460.924-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.05.10103081720460.924-100000@callisto.of.borg>; from geert@linux-m68k.org on Thu, Mar 08, 2001 at 05:21:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 05:21:32PM +0100, Geert Uytterhoeven wrote:
> On Thu, 8 Mar 2001, Steven Cole wrote:
> > It appears that use of CONFIG_NCR885E was removed in 2.4.2-ac2,
> > in Config.in and the Makefile in drivers/net.
> > 
> > If it really is the case that CONFIG_NCR885E is history, then it
> > should be history in Configure.help as well.
> 
> I'm still wondering whether there really are no other boards with a Sym53c885
> than the Synergy PPC board (which is no longer supported).

...which is supposed to be coming back as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
