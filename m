Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288334AbSACWTm>; Thu, 3 Jan 2002 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288336AbSACWT1>; Thu, 3 Jan 2002 17:19:27 -0500
Received: from air-1.osdl.org ([65.201.151.5]:39553 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S288334AbSACWSl>;
	Thu, 3 Jan 2002 17:18:41 -0500
Date: Thu, 3 Jan 2002 14:20:16 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alex <mail_ker@xarch.tu-graz.ac.at>,
        Horst von Brand <vonbrand@inf.utfsm.cl>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <E16MGJr-0001Gp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201031419400.826-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Alan Cox wrote:

> > I don't believe that Win2k does it (it's not from the PnP family, is it?).
> > But, I don't doubt that XP does it on contemporary hardware. It requires
> > ACPI support in the BIOS. And, ACPI enumerates all of the legacy devices
> > in the system.
>
> PnPBIOS also enumerates the legacy hardware that can be known about (ie
> is soldered down)

How do you derive that information? Some table, right? (Sorry, I haven't
RTFS yet).

	-pat

