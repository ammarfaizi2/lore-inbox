Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSGHSdC>; Mon, 8 Jul 2002 14:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSGHSdA>; Mon, 8 Jul 2002 14:33:00 -0400
Received: from msgdirector1.onetel.net.uk ([212.67.96.148]:20044 "EHLO
	msgdirector1.onetel.net.uk") by vger.kernel.org with ESMTP
	id <S317059AbSGHSbA>; Mon, 8 Jul 2002 14:31:00 -0400
Message-ID: <3D29DB3E.2C821971@onetel.net.uk>
Date: Mon, 08 Jul 2002 20:34:39 +0200
From: Matthias Fricke <matthiasfricke@onetel.net.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Ooops
References: <Pine.LNX.4.44.0207081206140.10105-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for the help, but sometimes the only way is to boot the
Micro(schrott)soft partition. There it told me yesterday
512 M of RAM, whereas today it states 260.080 MB RAM!? So, I will have to go
to the Hardware dealer tomorrow...

Matthias

Thunder from the hill wrote:

> Hi,
>
> On Mon, 8 Jul 2002, Matthias Fricke wrote:
> > I just tried to decrease the mem= parameter, but that does not work. It
> > crashes after having initialized the agpgart video support, wich I have
> > compiled in the kernel. Maybe I need to set up that as a module.
>
> ...and crash when loading the module.
>
> Is there a bios upgrade available for your system? Does it work if you
> fiddle around with the AGP aperture size in the BIOS? (Don't laugh - been
> there, done that! We've had a case where it worked.)
>
> > > Local APIC disabled by BIOS -- reenabling.
> > > Found and enabled local APIC!
>
> Can you enable this directly?
>
> > > eth[0-7]: D-Link DE-600 pocket adapter: not at I/O 0x378.
> > > D-Link DE-620 pocket adapter not identified in the printer port
>
> That part looks weird. There seems a bit more loose in your system?
>
>                                                         Regards,
>                                                         Thunder
> --
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y-
> ------END GEEK CODE BLOCK------

