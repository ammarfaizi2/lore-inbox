Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSABVT5>; Wed, 2 Jan 2002 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbSABVSR>; Wed, 2 Jan 2002 16:18:17 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:39043
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284282AbSABVSL>; Wed, 2 Jan 2002 16:18:11 -0500
Date: Wed, 2 Jan 2002 16:04:49 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102160449.A16019@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102154633.A15671@thyrsus.com> <E16Lsn2-0005XV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Lsn2-0005XV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 09:19:12PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > the machine and set ISA_CARDS based on the probe.  What's a DMI table and
> > how can I query it for the presence of ISA slots?
> 
> RTFG ;)

Umm...RTF*G*?  Sorry...can't parse. :-)

> > What I want to do with this is make ISA-card questions invisible on modern
> > PCI-only motherboards.
> 
> For the smart config I assume not in general ?

Right.  I'm well along on an autoconfigurator that can use the CML2 rulebase
to do things like freezing to N all the symbols for PCI devices not explicitly 
found by autoprobe.
 
> ftp://ftp.linux.org.uk/pub/linux/alan has a GPL DMI scanning app and library

Which directory is it?  Nothing has "dmi" in the name.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Everything that is really great and inspiring is created by the
individual who can labor in freedom.
	-- Albert Einstein, in H. Eves Return to Mathematical Circles, 
		Boston: Prindle, Weber and Schmidt, 1988.
