Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281144AbRKEN31>; Mon, 5 Nov 2001 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281145AbRKEN3R>; Mon, 5 Nov 2001 08:29:17 -0500
Received: from [208.232.58.25] ([208.232.58.25]:28639 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S281144AbRKEN3C>;
	Mon, 5 Nov 2001 08:29:02 -0500
Subject: RE: APM/ACPI
From: Sean Middleditch <elanthis@awesomeplay.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6EB@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6EB@orsmsx111.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 05 Nov 2001 08:28:12 -0500
Message-Id: <1004966892.13085.3.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, OK then.  ^,^

On Sun, 2001-11-04 at 23:06, Grover, Andrew wrote:
> Sean,
> 
> ACPI isn't ready for widespread consumption yet.
> 
> If you want to help us, check out
> http://phobos.fachschaften.tu-muenchen.de/acpi/ and send a proper bug report
> to the acpi mailing list.
> 
> Regards -- Andy
> ACPI maintainer
> 
> > From: Sean Middleditch [mailto:elanthis@awesomeplay.com]
> > Erg, hrm.  In 2.4.13 (Debian version, Linux tree I think) I enabled
> > ACPI, disabled APM.  The latop locks up when the base ACPI support is
> > loaded.
> > 
> > How should I go about debugging this?  I want this working.
> > 
> > Thanks,
> > Sean Etc.
> > 
> > On Fri, 2001-11-02 at 13:50, Alan Cox wrote:
> > > > OK, so there's a good chance then that if I compile in 
> > ACPI I can have
> > > > things work OK.  Do I need something besides apmd to 
> > handle all that? 
> > > > Will stuff like the GNOME battery applet still work?
> > > 
> > > If you compile in ACPI your box might work. You will need different 
> > > (development) tools and suspend wont work yet. ACPI is 
> > getting to the 
> > > useful point but not quite there - expect an adventure
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 


