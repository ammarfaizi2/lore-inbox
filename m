Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280784AbRKBSo1>; Fri, 2 Nov 2001 13:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280782AbRKBSnu>; Fri, 2 Nov 2001 13:43:50 -0500
Received: from air-1.osdl.org ([65.201.151.5]:9482 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280778AbRKBSmw>;
	Fri, 2 Nov 2001 13:42:52 -0500
Date: Fri, 2 Nov 2001 10:42:42 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: APM/ACPI
In-Reply-To: <1004725879.4921.36.camel@smiddle>
Message-ID: <Pine.LNX.4.33.0111021039130.15166-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Nov 2001, Sean Middleditch wrote:

> Hmm, not to point fingers or anything, but...
>
> "The WindowsXP that came preinstalled supported it!"

Windows XP requires systems to be fully ACPI (1.0b?) compliant. So, you
probably have an ACPII BIOS, though many BIOSes have some remnants of APM
left in them...

> I dunno, perhaps there is some proprietary protocol?  Is ACPI backwards
> compat with APM?  I mean, if the laptop doesn't support APM, would that
> mean it can't support ACPI?

Probably not, no, and no. ACPI support in Linux is still maturing, and
many things still do not work. I would recommend the ACPI mailing list and
archives for more assistance:

	http://phobos.fs.tum.de/acpi/index.html


	-pat


