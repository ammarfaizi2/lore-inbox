Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288615AbSADMae>; Fri, 4 Jan 2002 07:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288619AbSADMaY>; Fri, 4 Jan 2002 07:30:24 -0500
Received: from ns.suse.de ([213.95.15.193]:10257 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288615AbSADMaP>;
	Fri, 4 Jan 2002 07:30:15 -0500
Date: Fri, 4 Jan 2002 13:30:14 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alex <mail_ker@xarch.tu-graz.ac.at>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.10.10201041321330.16901-100000@xarch.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.33.0201041328190.18539-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Alex wrote:

> > You're still going to need user interaction for a lot of these.
> That is why I recommended that the textfile is the output of an
> interactive hardware-detection tool. Yes, interactive. :-)

vim /etc/modules.conf
is about as interactive as it gets.
If you want pointy clicky user interfaces for this, pretty much
every distro has one these days.

> > "But Microsoft doesn't" isn't an argument any more either, they dropped
> > support for really ancient hardware a long time ago.
> Show them that we can do better. :-D

On ancient hardware, we win, no contest. We're doing pretty good
with modern hardware also except for a few special cases.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

