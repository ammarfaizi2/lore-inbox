Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTHWRcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTHWRbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:31:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29331 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264271AbTHWRaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:30:17 -0400
Date: Sat, 23 Aug 2003 14:26:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Brown, Len" <len.brown@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, acpi-devel@sourceforge.net
Subject: RE: [patch] 2.4.x ACPI updates
In-Reply-To: <Pine.LNX.4.44.0308230015440.14227-100000@logos.cnet>
Message-ID: <Pine.LNX.4.55L.0308231426010.19711@freak.distro.conectiva>
References: <Pine.LNX.4.44.0308230015440.14227-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Aug 2003, Marcelo Tosatti wrote:

>
>
> On Fri, 22 Aug 2003, Brown, Len wrote:
>
> > Hi Marcelo,
> > A small update to what you pulled this morning --
> > fixes config options CONFIG_ACPI_HT_ONLY and CONFIG_HOTPLUG_PCI_ACPI.
> >
> > I'm looking forward to deleting these #ifdef CONFIG_ACPI_HT_ONLY
> > When we can (again) delete acpitable.[ch] in 2.4.23.
> >
> > Please
> >
> > 	bk pull http://linux-acpi.bkbits.net/linux-acpi-2.4.22
> >
> > This
> >
> > This will update the following files:
> >
> >  drivers/hotplug/Config.in |    5 +++--
> >  include/asm-i386/acpi.h   |    7 +++++++
> >  include/linux/acpi.h      |    6 ++++++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > through these ChangeSets:
> >
> > <len.brown@intel.com> (03/08/22 1.1107)
> >    linux-acpi-2.4.22.patch
>
> Len,
>
> Patch applied, thanks.
>
> Do you have any further information on the ACPI oops reports I sent you?
>
> Thanks
>
>
