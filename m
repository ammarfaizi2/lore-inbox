Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284924AbSADUso>; Fri, 4 Jan 2002 15:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSADUsf>; Fri, 4 Jan 2002 15:48:35 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:62609
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284924AbSADUsY>; Fri, 4 Jan 2002 15:48:24 -0500
Date: Fri, 4 Jan 2002 15:33:05 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104153305.C20097@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.3.96.1020104211143.829K-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33.0201042128360.20620-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201042128360.20620-100000@Appserv.suse.de>; from davej@suse.de on Fri, Jan 04, 2002 at 09:31:14PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> Indeed. Something I'm trying to convey to Eric, but I don't think
> he realises just how many pooched BIOSen there are out there.
> His conservative estimate of '150 entries in the blacklist'
> is possibly off by an order of 10 times or more.

Are there even 1500 distinct PC motherboard designs in *existence*? :-)

Think, Dave.  The DMI standard dates from 1998.  For there to be 1500
entries on the blacklist, someone would have to have been cranking out
*500* PCI-capable, DMI-supporting motherboard designs a year each and
every one of which lies about having ISA slots.

This seems...implausible.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

It would be thought a hard government that should tax its people one tenth 
part.	-- Benjamin Franklin
