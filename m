Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293032AbSCFBxI>; Tue, 5 Mar 2002 20:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293027AbSCFBw6>; Tue, 5 Mar 2002 20:52:58 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46602
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293022AbSCFBwL> convert rfc822-to-8bit; Tue, 5 Mar 2002 20:52:11 -0500
Date: Tue, 5 Mar 2002 17:50:59 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Kernel panic
In-Reply-To: <20020306024001.A9217@bouton.inet6-interne.fr>
Message-ID: <Pine.LNX.4.10.10203051746580.18118-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lionel,

Please add your name to the Maintainer List for the SIS5513 chipset code.
As you have the hardware and testing it and answering questions, for what
it is worth imho, you have earn the right to put your name there.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


On Wed, 6 Mar 2002, Lionel Bouton wrote:

> On Tue, Mar 05, 2002 at 11:31:41PM +0100, Hanno Böck wrote:
> > I have a PC with an Athlon CPU, which has problems with newer kernel-versions. (see lspci-output below)
> > 
> > If I want to boot current Knoppix or Mandrake 8.2beta3 install cds (both based on kernel 2.4.17), it says:
> > 
> > Kernel panic: VFS: Unable to mount root fs on 03:05
> > 
> > It worked fine with the older mandrake 8.1 with kernel 2.4.8.
> > 
> > Any ideas? How can I help to fix this?
> > 
> 
> Try passing ide=nodma during install and following reboot(s) then fetch a patch
> at:
> http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html
> , apply, recompile, install.
> 
> SiS730 support should be OK with latest patches.
> 
> LB.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

