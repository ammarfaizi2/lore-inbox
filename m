Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280197AbRKEEGx>; Sun, 4 Nov 2001 23:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280192AbRKEEGo>; Sun, 4 Nov 2001 23:06:44 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:25025 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S280197AbRKEEGi>; Sun, 4 Nov 2001 23:06:38 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6EB@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Sean Middleditch'" <elanthis@awesomeplay.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: APM/ACPI
Date: Sun, 4 Nov 2001 20:06:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

ACPI isn't ready for widespread consumption yet.

If you want to help us, check out
http://phobos.fachschaften.tu-muenchen.de/acpi/ and send a proper bug report
to the acpi mailing list.

Regards -- Andy
ACPI maintainer

> From: Sean Middleditch [mailto:elanthis@awesomeplay.com]
> Erg, hrm.  In 2.4.13 (Debian version, Linux tree I think) I enabled
> ACPI, disabled APM.  The latop locks up when the base ACPI support is
> loaded.
> 
> How should I go about debugging this?  I want this working.
> 
> Thanks,
> Sean Etc.
> 
> On Fri, 2001-11-02 at 13:50, Alan Cox wrote:
> > > OK, so there's a good chance then that if I compile in 
> ACPI I can have
> > > things work OK.  Do I need something besides apmd to 
> handle all that? 
> > > Will stuff like the GNOME battery applet still work?
> > 
> > If you compile in ACPI your box might work. You will need different 
> > (development) tools and suspend wont work yet. ACPI is 
> getting to the 
> > useful point but not quite there - expect an adventure
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
