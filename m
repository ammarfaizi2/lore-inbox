Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288455AbSADCYV>; Thu, 3 Jan 2002 21:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288454AbSADCYL>; Thu, 3 Jan 2002 21:24:11 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:3272 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S288453AbSADCYC>; Thu, 3 Jan 2002 21:24:02 -0500
Date: Fri, 4 Jan 2002 03:15:53 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual athlon XP 1800 problems
Message-ID: <20020104021553.GB3474@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C311B00.FFB58648@get2chip.com> <20020101032335.A11129@suse.de> <1009868304.27412.2.camel@zaphod> <20020103165321.GA737@bombe.modem.informatik.tu-muenchen.de> <a125gv$l3b$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a125gv$l3b$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 09:48:15AM -0800, H. Peter Anvin wrote:
> Followup to:  <20020103165321.GA737@bombe.modem.informatik.tu-muenchen.de>
> By author:    Andreas Bombe <bombe@informatik.tu-muenchen.de>
> In newsgroup: linux.dev.kernel
> > 
> > The identification string is written by the BIOS.  Yours didn't know
> > about XPs so it misidentified them as MPs.  Upgrade your BIOS if this
> > bugs you.
> > 
> > If ID string contradicts what you think you bought, don't trust the ID
> > string.
> > 
> 
> This seems very odd.  I thought in Athlon processors the ID string
> came from the *CPU* (via CPUID), not the BIOS...

It comes from there, but it is written there by the BIOS for Athlon (and
I guess Duron, too).

http://www.heise.de/newsticker/data/jow-18.10.01-000/ (in German)

I searched a bit with Google but couldn't find an English page with that
info right now.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
