Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288777AbSADVOo>; Fri, 4 Jan 2002 16:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288776AbSADVOe>; Fri, 4 Jan 2002 16:14:34 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:14994
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288775AbSADVOZ>; Fri, 4 Jan 2002 16:14:25 -0500
Date: Fri, 4 Jan 2002 15:59:12 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104155912.A23345@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020104154935.F20097@thyrsus.com> <Pine.LNX.4.33.0201042208350.20620-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201042208350.20620-100000@Appserv.suse.de>; from davej@suse.de on Fri, Jan 04, 2002 at 10:08:44PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> > Waitaminute.  DMI is a *dying* standard?  What, if anything, is
> > replacing it?
> 
> ACPI

OK.  So can I ask ACPI if the board has ISA slots?  Does it answer 
reliably?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The kind of charity you can force out of people nourishes about as much as
the kind of love you can buy --- and spreads even nastier diseases.
