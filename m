Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286679AbRL1ByD>; Thu, 27 Dec 2001 20:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286678AbRL1Bxv>; Thu, 27 Dec 2001 20:53:51 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:2256
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286655AbRL1Bw7>; Thu, 27 Dec 2001 20:52:59 -0500
Date: Thu, 27 Dec 2001 20:37:37 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA core vs. ISA card support
Message-ID: <20011227203737.B28510@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011227200238.B26889@thyrsus.com> <E16Jlq0-0007bm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Jlq0-0007bm-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 28, 2001 at 01:29:32AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Thanks, that's helpful.  I'll introduce an ISA_SLOTS private symbol, then.
> > Later perhaps we can actually make this distinction in C code;  sounds
> > like it would be a good idea.
> 
> There is no value to it in the kernel. ISA bus and magic that looks like
> ISA bus but is welded to the motherboard look the same anyway

OK, noted.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders, give
orders, cooperate, act alone, solve equations, analyze a new problem,
pitch manure, program a computer, cook a tasty meal, fight efficiently,
die gallantly. Specialization is for insects.
	-- Robert A. Heinlein, "Time Enough for Love"
