Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSGHSMh>; Mon, 8 Jul 2002 14:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSGHSMg>; Mon, 8 Jul 2002 14:12:36 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:54487 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316996AbSGHSMf>; Mon, 8 Jul 2002 14:12:35 -0400
Date: Mon, 8 Jul 2002 12:15:08 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Matthias Fricke <matthiasfricke@onetel.net.uk>
cc: Gilad Ben-Yossef <gilad@benyossef.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Ooops
In-Reply-To: <3D29D1CD.18E7B128@onetel.net.uk>
Message-ID: <Pine.LNX.4.44.0207081206140.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jul 2002, Matthias Fricke wrote:
> I just tried to decrease the mem= parameter, but that does not work. It
> crashes after having initialized the agpgart video support, wich I have
> compiled in the kernel. Maybe I need to set up that as a module.

...and crash when loading the module.

Is there a bios upgrade available for your system? Does it work if you 
fiddle around with the AGP aperture size in the BIOS? (Don't laugh - been 
there, done that! We've had a case where it worked.)

> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!

Can you enable this directly?

> > eth[0-7]: D-Link DE-600 pocket adapter: not at I/O 0x378.
> > D-Link DE-620 pocket adapter not identified in the printer port

That part looks weird. There seems a bit more loose in your system?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

