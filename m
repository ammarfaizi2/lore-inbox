Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280781AbRKBS7J>; Fri, 2 Nov 2001 13:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280795AbRKBS6E>; Fri, 2 Nov 2001 13:58:04 -0500
Received: from [208.232.58.25] ([208.232.58.25]:60887 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280797AbRKBS5T>;
	Fri, 2 Nov 2001 13:57:19 -0500
Subject: Re: APM/ACPI
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: Patrick Mochel <mochel@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111021039130.15166-100000@osdlab.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0111021039130.15166-100000@osdlab.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 13:56:46 -0500
Message-Id: <1004727406.4883.51.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alrighty!  Thank you!  I'll play around and see if I can't get it to
work.  I don't really care about suspend and whatnot at the moment, I
just want a warning when my battery is getting low.  ~,^

Sean Etc.

On Fri, 2001-11-02 at 13:42, Patrick Mochel wrote:
> 
> On 2 Nov 2001, Sean Middleditch wrote:
> 
> > Hmm, not to point fingers or anything, but...
> >
> > "The WindowsXP that came preinstalled supported it!"
> 
> Windows XP requires systems to be fully ACPI (1.0b?) compliant. So, you
> probably have an ACPII BIOS, though many BIOSes have some remnants of APM
> left in them...
> 
> > I dunno, perhaps there is some proprietary protocol?  Is ACPI backwards
> > compat with APM?  I mean, if the laptop doesn't support APM, would that
> > mean it can't support ACPI?
> 
> Probably not, no, and no. ACPI support in Linux is still maturing, and
> many things still do not work. I would recommend the ACPI mailing list and
> archives for more assistance:
> 
> 	http://phobos.fs.tum.de/acpi/index.html
> 
> 
> 	-pat
> 
> 


