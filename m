Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288760AbSADU5P>; Fri, 4 Jan 2002 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288762AbSADU5F>; Fri, 4 Jan 2002 15:57:05 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:38153 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288760AbSADU44>; Fri, 4 Jan 2002 15:56:56 -0500
Date: Fri, 4 Jan 2002 21:56:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104215654.A23185@suse.cz>
In-Reply-To: <Pine.GSO.3.96.1020104211143.829K-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33.0201042128360.20620-100000@Appserv.suse.de> <20020104153305.C20097@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104153305.C20097@thyrsus.com>; from esr@thyrsus.com on Fri, Jan 04, 2002 at 03:33:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 03:33:05PM -0500, Eric S. Raymond wrote:
> Dave Jones <davej@suse.de>:
> > Indeed. Something I'm trying to convey to Eric, but I don't think
> > he realises just how many pooched BIOSen there are out there.
> > His conservative estimate of '150 entries in the blacklist'
> > is possibly off by an order of 10 times or more.
> 
> Are there even 1500 distinct PC motherboard designs in *existence*? :-)

Definitely. And multiply that with BIOS revisions.

> Think, Dave.  The DMI standard dates from 1998.  For there to be 1500
> entries on the blacklist, someone would have to have been cranking out
> *500* PCI-capable, DMI-supporting motherboard designs a year each and
> every one of which lies about having ISA slots.
> 
> This seems...implausible.

Not to me.

-- 
Vojtech Pavlik
SuSE Labs
